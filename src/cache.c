/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>

#include "../headers/operations.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

int cmd_clean_v2(void) {
    char cmd[512];
    int rc;

    /* Incomplete parallel downloads leave download-* files that make
       pacman -Sc print "error: could not open file ... (Error reading fd)".
       Drop them first so the cache clean itself can finish. */
    printf(COLOR_BLUE ">>> Removing leftover pacman download fragments...\n"
           COLOR_RESET);
    run_cmd("find /var/cache/pacman/pkg -maxdepth 1 \\( -type f -o -type d \\) "
            "-name 'download-*' -exec rm -rf {} + 2>/dev/null || true");

    printf(COLOR_BLUE ">>> Cleaning uninstalled package cache...\n" COLOR_RESET);
    /* Always pass --noconfirm unless the user asked for interactive pacman.
       Overnight / scripted runs otherwise hang on "[J/n]". */
    xsnprintf(cmd, sizeof(cmd), "%spacman -Sc%s",
              priv_prefix(), use_noconfirm() ? " --noconfirm" : "");
    rc = run_cmd(cmd);
    if (rc != 0) {
        fprintf(stderr, COLOR_RED "[-] pacman cache clean failed (exit %d).\n"
                COLOR_RESET, rc);
        return 0;
    }
    return 1;
}
