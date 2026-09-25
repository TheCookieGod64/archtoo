/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/operations.h"
#include "../headers/utils.h"
#include "../headers/config.h"
#include "../headers/colors.h"
#include "../headers/version.h"

static long count_nonempty_lines(const char *text) {
    long n = 0;
    const char *p = text ? text : "";
    while (*p) {
        const char *nl = strchr(p, '\n');
        size_t len = nl ? (size_t)(nl - p) : strlen(p);
        int blank = 1;
        for (size_t i = 0; i < len; i++) {
            if (p[i] != ' ' && p[i] != '\t' && p[i] != '\r') {
                blank = 0;
                break;
            }
        }
        if (!blank)
            n++;
        if (!nl)
            break;
        p = nl + 1;
    }
    return n;
}

static long count_cmd_lines(const char *cmd) {
    char *out = NULL;
    long n;
    int rc = run_cmd_capture(cmd, &out);
    if (rc != 0 && rc != 1) {
        free(out);
        return -1;
    }
    n = count_nonempty_lines(out);
    free(out);
    return n;
}

int cmd_stats_v2(void) {
    long installed, foreign, explicit_pkgs, orphans, world = 0;
    FILE *wf;

    installed = count_cmd_lines("pacman -Qq");
    foreign = count_cmd_lines("pacman -Qmq");
    explicit_pkgs = count_cmd_lines("pacman -Qeq");
    orphans = count_cmd_lines("pacman -Qdtq");
    if (installed < 0 || foreign < 0 || explicit_pkgs < 0) {
        fprintf(stderr, COLOR_RED "[-] Could not query pacman package lists.\n"
                COLOR_RESET);
        return 0;
    }
    if (orphans < 0)
        orphans = 0;

    wf = fopen(WORLD_FILE, "r");
    if (wf) {
        char line[256];
        while (fgets(line, sizeof(line), wf)) {
            char *p = line;
            while (*p == ' ' || *p == '\t')
                p++;
            if (*p && *p != '#' && *p != '\n')
                world++;
        }
        fclose(wf);
    }

    printf(COLOR_CYAN "%s v%s\n" COLOR_RESET, ARCHTOO_NAME, ARCHTOO_VERSION);
    printf("Installed packages : %ld\n", installed);
    printf("Explicit packages  : %ld\n", explicit_pkgs);
    printf("Foreign packages   : %ld\n", foreign);
    printf("Orphaned packages  : %ld\n", orphans);
    printf("@world entries     : %ld\n", world);
    return 1;
}
