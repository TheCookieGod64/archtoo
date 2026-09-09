/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/operations.h"
#include "../headers/aur_rpc.h"
#include "../headers/config.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

int cmd_search_v2(const char *query) {
    char quoted[320];
    char cmd[512];
    char *repo_out = NULL;
    char error[256] = "";
    aur_response_t response = {0};
    int ok = 0;
    int repo_rc;

    if (!valid_search_query(query)) {
        fprintf(stderr, COLOR_RED "[-] Invalid search query: '%s'\n" COLOR_RESET,
                query ? query : "");
        return 0;
    }
    if (!shell_quote(query, quoted, sizeof(quoted)))
        return 0;

    printf(COLOR_CYAN ">>> Repositories\n" COLOR_RESET);
    xsnprintf(cmd, sizeof(cmd), "pacman -Ss -- %s", quoted);
    repo_rc = run_cmd_capture(cmd, &repo_out);
    if (repo_rc == 0 && repo_out && *repo_out) {
        fputs(repo_out, stdout);
        if (repo_out[strlen(repo_out) - 1] != '\n')
            putchar('\n');
        ok = 1;
    } else {
        printf("    (no repository matches)\n");
    }
    free(repo_out);

    printf(COLOR_CYAN ">>> AUR\n" COLOR_RESET);
    if (aur_rpc_search(config_current()->aur_rpc_url, query, &response,
                       error, sizeof(error))) {
        if (response.count == 0) {
            printf("    (no AUR matches)\n");
        } else {
            for (size_t i = 0; i < response.count; i++) {
                const aur_package_t *p = &response.packages[i];
                printf("aur/%s %s", p->name ? p->name : "?",
                       p->version ? p->version : "");
                if (p->votes)
                    printf(" (%ld votes)", p->votes);
                putchar('\n');
                if (p->description && *p->description)
                    printf("    %s\n", p->description);
            }
            ok = 1;
        }
    } else {
        fprintf(stderr, COLOR_YELLOW "[!] AUR RPC: %s\n" COLOR_RESET, error);
    }
    aur_response_destroy(&response);
    return ok;
}
