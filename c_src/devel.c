/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/operations.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

int cmd_devel_v2(void) {
    char *out = NULL;
    int rc = run_cmd_capture("pacman -Qmq", &out);
    int found = 0;
    const char *p;

    if (rc != 0 && rc != 1) {
        fprintf(stderr, COLOR_RED "[-] Could not list foreign packages.\n"
                COLOR_RESET);
        free(out);
        return 0;
    }

    printf(COLOR_CYAN ">>> Development / VCS packages (-git/-hg/-svn/-bzr/-cvs)\n"
           COLOR_RESET);
    p = out ? out : "";
    while (*p) {
        const char *nl = strchr(p, '\n');
        size_t len = nl ? (size_t)(nl - p) : strlen(p);
        char name[160];

        if (len > 0 && len < sizeof(name)) {
            memcpy(name, p, len);
            name[len] = '\0';
            if (strstr(name, "-git") || strstr(name, "-hg") ||
                strstr(name, "-svn") || strstr(name, "-bzr") ||
                strstr(name, "-cvs")) {
                puts(name);
                found = 1;
            }
        }
        if (!nl)
            break;
        p = nl + 1;
    }
    free(out);

    if (!found)
        printf("No development packages installed.\n");
    return 1;
}
