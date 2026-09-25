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

static int print_aur_info(const char *name) {
    aur_response_t response = {0};
    char error[256] = "";

    if (!aur_rpc_info(config_current()->aur_rpc_url, name, &response,
                      error, sizeof(error))) {
        fprintf(stderr, COLOR_RED "[-] %s\n" COLOR_RESET, error);
        return 0;
    }
    if (response.count == 0) {
        fprintf(stderr, COLOR_RED "[-] Package '%s' was not found in repositories or the AUR.\n"
                COLOR_RESET, name);
        aur_response_destroy(&response);
        return 0;
    }

    for (size_t i = 0; i < response.count; i++) {
        const aur_package_t *p = &response.packages[i];
        printf("Repository      : aur\n");
        printf("Name            : %s\n", p->name ? p->name : "");
        printf("Package Base    : %s\n", p->package_base ? p->package_base : "");
        printf("Version         : %s\n", p->version ? p->version : "");
        printf("Description     : %s\n", p->description ? p->description : "");
        printf("URL             : %s\n", p->url ? p->url : "");
        printf("Maintainer      : %s\n", p->maintainer && *p->maintainer
               ? p->maintainer : "(orphan)");
        printf("Votes           : %ld\n", p->votes);
        printf("Popularity      : %.2f\n", p->popularity);
        if (p->out_of_date)
            printf("Out Of Date     : %ld\n", p->out_of_date);

        printf("Depends On      :");
        if (p->depends_count == 0)
            printf(" None");
        for (size_t j = 0; j < p->depends_count; j++)
            printf(" %s", p->depends[j]);
        putchar('\n');

        printf("Make Deps       :");
        if (p->make_depends_count == 0)
            printf(" None");
        for (size_t j = 0; j < p->make_depends_count; j++)
            printf(" %s", p->make_depends[j]);
        putchar('\n');

        printf("Check Deps      :");
        if (p->check_depends_count == 0)
            printf(" None");
        for (size_t j = 0; j < p->check_depends_count; j++)
            printf(" %s", p->check_depends[j]);
        putchar('\n');

        printf("Provides        :");
        if (p->provides_count == 0)
            printf(" None");
        for (size_t j = 0; j < p->provides_count; j++)
            printf(" %s", p->provides[j]);
        putchar('\n');

        printf("Conflicts With  :");
        if (p->conflicts_count == 0)
            printf(" None");
        for (size_t j = 0; j < p->conflicts_count; j++)
            printf(" %s", p->conflicts[j]);
        putchar('\n');

        if (i + 1 < response.count)
            putchar('\n');
    }
    aur_response_destroy(&response);
    return 1;
}

int cmd_available_info_v2(const char *name) {
    char quoted[320];
    char cmd[512];
    char *out = NULL;
    int rc;

    if (!valid_pkgname(name)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET,
                name ? name : "");
        return 0;
    }
    if (!shell_quote(name, quoted, sizeof(quoted)))
        return 0;

    /* Capture (stderr discarded) so a missing repo package does not print
       pacman's "error: package 'hello' was not found" before the AUR info. */
    xsnprintf(cmd, sizeof(cmd), "pacman -Si -- %s", quoted);
    rc = run_cmd_capture(cmd, &out);
    if (rc == 0 && out && *out) {
        fputs(out, stdout);
        if (out[strlen(out) - 1] != '\n')
            putchar('\n');
        free(out);
        return 1;
    }
    free(out);
    return print_aur_info(name);
}

int cmd_query_v2(const char *name) {
    char quoted[320];
    char cmd[512];

    if (!valid_pkgname(name)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET,
                name ? name : "");
        return 0;
    }
    if (!shell_quote(name, quoted, sizeof(quoted)))
        return 0;
    xsnprintf(cmd, sizeof(cmd), "pacman -Qi -- %s", quoted);
    return run_cmd(cmd) == 0;
}
