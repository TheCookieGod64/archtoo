/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "../headers/operations.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

int cmd_get_pkgbuild_v2(const char *name) {
    char quoted[320];
    char cmd[1024];
    char pkgbuild[512];

    if (!valid_pkgname(name)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET,
                name ? name : "");
        return 0;
    }
    if (!shell_quote(name, quoted, sizeof(quoted)))
        return 0;

    xsnprintf(pkgbuild, sizeof(pkgbuild), "%s/PKGBUILD", name);
    if (dir_exists(name) && file_exists(pkgbuild)) {
        printf(COLOR_BLUE ">>> Updating existing checkout %s\n" COLOR_RESET, name);
        xsnprintf(cmd, sizeof(cmd),
                  "GIT_TERMINAL_PROMPT=0 git -C %s pull --ff-only", quoted);
    } else {
        printf(COLOR_BLUE ">>> Cloning https://aur.archlinux.org/%s.git\n"
               COLOR_RESET, name);
        xsnprintf(cmd, sizeof(cmd),
                  "GIT_TERMINAL_PROMPT=0 git clone -- "
                  "'https://aur.archlinux.org/%s.git' %s", name, quoted);
    }
    if (run_as_user(cmd, NULL) != 0) {
        fprintf(stderr, COLOR_RED "[-] Could not fetch PKGBUILD for '%s'.\n"
                COLOR_RESET, name);
        return 0;
    }
    if (!file_exists(pkgbuild)) {
        fprintf(stderr, COLOR_RED "[-] Clone succeeded but %s is missing.\n"
                COLOR_RESET, pkgbuild);
        return 0;
    }
    printf(COLOR_GREEN "[+] PKGBUILD is at %s\n" COLOR_RESET, pkgbuild);
    return 1;
}

int cmd_local_build_v2(const char *directory) {
    char quoted[1024];
    char cmd[2048];
    char pkgbuild[1200];

    if (!directory || !*directory) {
        fprintf(stderr, COLOR_RED "[-] Local build requires a directory.\n"
                COLOR_RESET);
        return 0;
    }
    if (strchr(directory, '\n') || strchr(directory, '\r')) {
        fprintf(stderr, COLOR_RED "[-] Invalid build directory.\n" COLOR_RESET);
        return 0;
    }
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

    printf(COLOR_BLUE ">>> Building local PKGBUILD in %s\n" COLOR_RESET,
           directory);
    xsnprintf(cmd, sizeof(cmd), "cd %s && makepkg -f%s", quoted,
              use_noconfirm() ? " --noconfirm" : "");
    if (run_as_user(cmd, NULL) != 0) {
        fprintf(stderr, COLOR_RED "[-] Local build failed.\n" COLOR_RESET);
        return 0;
    }
    return 1;
}
