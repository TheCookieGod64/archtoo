/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <string.h>

#include "../headers/operations.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

int cmd_review_v2(const char *directory) {
    char quoted[1024];
    char pkgbuild[1200];
    char srcinfo[1200];
    char gitdir[1200];
    char cmd[2048];

    if (!directory || !*directory) {
        fprintf(stderr, COLOR_RED "[-] Review requires a directory.\n" COLOR_RESET);
        return 0;
    }
    if (strchr(directory, '\n') || strchr(directory, '\r'))
        return 0;
    if (!dir_exists(directory)) {
        fprintf(stderr, COLOR_RED "[-] Directory does not exist: %s\n"
                COLOR_RESET, directory);
        return 0;
    }
    xsnprintf(pkgbuild, sizeof(pkgbuild), "%s/PKGBUILD", directory);
    if (!file_exists(pkgbuild)) {
        fprintf(stderr, COLOR_RED "[-] No PKGBUILD in %s\n" COLOR_RESET,
                directory);
        return 0;
    }
    if (!shell_quote(directory, quoted, sizeof(quoted)))
        return 0;

    xsnprintf(gitdir, sizeof(gitdir), "%s/.git", directory);
    if (dir_exists(gitdir)) {
        printf(COLOR_CYAN ">>> git diff (PKGBUILD / .SRCINFO)\n" COLOR_RESET);
        xsnprintf(cmd, sizeof(cmd),
                  "git -C %s diff -- PKGBUILD .SRCINFO", quoted);
        run_cmd(cmd);
    }

    xsnprintf(srcinfo, sizeof(srcinfo), "%s/.SRCINFO", directory);
    if (file_exists(srcinfo)) {
        printf(COLOR_CYAN ">>> .SRCINFO\n" COLOR_RESET);
        xsnprintf(cmd, sizeof(cmd), "sed -n '1,120p' %s/.SRCINFO", quoted);
        run_cmd(cmd);
    }

    printf(COLOR_CYAN ">>> PKGBUILD\n" COLOR_RESET);
    xsnprintf(cmd, sizeof(cmd), "sed -n '1,240p' %s/PKGBUILD", quoted);
    return run_cmd(cmd) == 0;
}
