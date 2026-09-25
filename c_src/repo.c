/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>

#include "../headers/operations.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

int cmd_repo_install_v2(const char *name) {
    char quoted[320];
    char cmd[640];

    if (!valid_pkgname(name)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET,
                name ? name : "");
        return 0;
    }
    if (!shell_quote(name, quoted, sizeof(quoted)))
        return 0;

    printf(COLOR_BLUE ">>> Installing repository package %s\n" COLOR_RESET, name);
    xsnprintf(cmd, sizeof(cmd), "%spacman -S --needed%s -- %s",
              priv_prefix(), use_noconfirm() ? " --noconfirm --ask=6" : "",
              quoted);
    if (run_cmd(cmd) != 0) {
        fprintf(stderr, COLOR_RED "[-] Could not install '%s' from repositories.\n"
                COLOR_RESET, name);
        return 0;
    }
    return 1;
}
