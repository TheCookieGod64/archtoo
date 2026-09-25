/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/operations.h"
#include "../headers/aur_rpc.h"
#include "../headers/config.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

static char *trim_copy(const char *s, size_t n) {
    while (n && isspace((unsigned char)*s)) {
        s++;
        n--;
    }
    while (n && isspace((unsigned char)s[n - 1]))
        n--;
    char *out = malloc(n + 1);
    if (!out)
        return NULL;
    memcpy(out, s, n);
    out[n] = '\0';
    return out;
}

static int provides_token_matches(const char *token, const char *want) {
    char base[256];
    dep_basename(token, base, sizeof(base));
    return base[0] && strcmp(base, want) == 0;
}

static int print_repo_providers(const char *name) {
    char quoted[320];
    char cmd[4096];
    char *ssq = NULL;
    char *info = NULL;
    char *candidates[80];
    size_t n_cand = 0;
    int found = 0;
    const char *p;

    if (!shell_quote(name, quoted, sizeof(quoted)))
        return 0;

    /* Substring search only produces *candidates*. We then keep a package
       only if its Name is exactly `name` or one of its Provides tokens is. */
    xsnprintf(cmd, sizeof(cmd), "pacman -Ssq -- %s", quoted);
    (void)run_cmd_capture(cmd, &ssq);

    if (ssq) {
        p = ssq;
        while (*p && n_cand < 80) {
            const char *nl = strchr(p, '\n');
            size_t len = nl ? (size_t)(nl - p) : strlen(p);
            char pkg[160];

            if (len > 0 && len < sizeof(pkg)) {
                memcpy(pkg, p, len);
                pkg[len] = '\0';
                if (valid_pkgname(pkg))
                    candidates[n_cand++] = strdup(pkg);
            }
            if (!nl)
                break;
            p = nl + 1;
        }
    }
    free(ssq);

    if (n_cand == 0)
        return 0;

    {
        size_t used = 0;
        const char *prefix = "pacman -Si --";
        used = strlen(prefix);
        memcpy(cmd, prefix, used + 1);
        for (size_t i = 0; i < n_cand; i++) {
            char q[320];
            size_t qlen;
            if (!candidates[i] || !shell_quote(candidates[i], q, sizeof(q)))
                continue;
            qlen = strlen(q);
            if (used + 1 + qlen >= sizeof(cmd))
                break;
            cmd[used++] = ' ';
            memcpy(cmd + used, q, qlen);
            used += qlen;
            cmd[used] = '\0';
        }
    }

    if (run_cmd_capture(cmd, &info) == 0 && info && *info) {
        char *block = info;
        while (block && *block) {
            char *next = strstr(block, "\nRepository");
            char *name_line, *ver_line, *repo_line, *prov_line;
            char *pkg_name = NULL, *pkg_ver = NULL, *pkg_repo = NULL;
            int is_exact = 0, is_provider = 0;
            char *section_end;

            if (next == block)
                next = strstr(block + 1, "\nRepository");
            section_end = next ? next : block + strlen(block);

            repo_line = strstr(block, "Repository");
            name_line = strstr(block, "\nName");
            ver_line = strstr(block, "\nVersion");
            prov_line = strstr(block, "\nProvides");
            if (repo_line && repo_line < section_end) {
                char *colon = strchr(repo_line, ':');
                if (colon && colon < section_end) {
                    char *eol = strchr(colon, '\n');
                    pkg_repo = trim_copy(colon + 1,
                                         (eol ? (size_t)(eol - colon - 1)
                                              : strlen(colon + 1)));
                }
            }
            if (name_line && name_line < section_end) {
                char *colon = strchr(name_line, ':');
                if (colon && colon < section_end) {
                    char *eol = strchr(colon, '\n');
                    pkg_name = trim_copy(colon + 1,
                                         (eol ? (size_t)(eol - colon - 1)
                                              : strlen(colon + 1)));
                }
            }
            if (ver_line && ver_line < section_end) {
                char *colon = strchr(ver_line, ':');
                if (colon && colon < section_end) {
                    char *eol = strchr(colon, '\n');
                    pkg_ver = trim_copy(colon + 1,
                                        (eol ? (size_t)(eol - colon - 1)
                                             : strlen(colon + 1)));
                }
            }
            if (pkg_name && strcmp(pkg_name, name) == 0)
                is_exact = 1;
            if (prov_line && prov_line < section_end) {
                char *colon = strchr(prov_line, ':');
                if (colon && colon < section_end) {
                    char *eol = strchr(colon, '\n');
                    char *list = trim_copy(colon + 1,
                                           (eol ? (size_t)(eol - colon - 1)
                                                : strlen(colon + 1)));
                    if (list && strcmp(list, "None") != 0) {
                        char *tok, *save = NULL;
                        for (tok = strtok_r(list, " \t", &save); tok;
                             tok = strtok_r(NULL, " \t", &save)) {
                            if (provides_token_matches(tok, name)) {
                                is_provider = 1;
                                break;
                            }
                        }
                    }
                    free(list);
                }
            }

            if (pkg_name && (is_exact || is_provider)) {
                printf("%s/%s %s  %s\n",
                       pkg_repo && *pkg_repo ? pkg_repo : "repo",
                       pkg_name,
                       pkg_ver ? pkg_ver : "",
                       is_exact ? "(package)" : "(provides)");
                found = 1;
            }
            free(pkg_name);
            free(pkg_ver);
            free(pkg_repo);

            if (!next)
                break;
            block = next + 1;
        }
    }
    free(info);
    for (size_t i = 0; i < n_cand; i++)
        free(candidates[i]);
    return found;
}

int cmd_provider_v2(const char *name) {
    aur_response_t response = {0};
    char error[256] = "";
    int found = 0;

    if (!valid_pkgname(name)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET,
                name ? name : "");
        return 0;
    }

    printf(COLOR_CYAN ">>> Providers of %s\n" COLOR_RESET, name);
    if (print_repo_providers(name))
        found = 1;

    if (aur_rpc_info(config_current()->aur_rpc_url, name, &response,
                     error, sizeof(error)) && response.count > 0) {
        for (size_t i = 0; i < response.count; i++) {
            const aur_package_t *p = &response.packages[i];
            int is_exact = p->name && strcmp(p->name, name) == 0;
            int is_provider = 0;
            for (size_t j = 0; j < p->provides_count; j++) {
                if (provides_token_matches(p->provides[j], name)) {
                    is_provider = 1;
                    break;
                }
            }
            if (is_exact || is_provider) {
                printf("aur/%s %s  %s\n",
                       p->name ? p->name : "?",
                       p->version ? p->version : "",
                       is_exact ? "(package)" : "(provides)");
                found = 1;
            }
        }
    }
    aur_response_destroy(&response);

    if (!found) {
        fprintf(stderr, COLOR_YELLOW "[!] No providers found for '%s'.\n"
                COLOR_RESET, name);
        return 0;
    }
    return 1;
}
