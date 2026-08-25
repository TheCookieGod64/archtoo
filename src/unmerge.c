/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#include <stdio.h>
#include <stdlib.h>

#include "../headers/unmerge.h"
#include "../headers/kernel.h"
#include "../headers/world.h"
#include "../headers/utils.h"
#include "../headers/config.h"
#include "../headers/colors.h"

void unlock_pacman_pkg(const char *pkg) {
    char esc[320];
    char cmd[2048];

    if (!regex_escape(pkg, esc, sizeof(esc)))
        return;

    /* Whole-token removal. The old '\<pkg\>' treated '-' as a word boundary,
       so unlocking "linux" turned "linux-zen linux-headers" into
       "-zen -headers" and corrupted pacman.conf. */
    xsnprintf(cmd, sizeof(cmd),
             "%ssed -i -E '/^[[:space:]]*IgnorePkg[[:space:]]*=/{"
             "s/[[:space:]]+%s([[:space:]]|$)/\\1/g;"
             "s/=[[:space:]]*%s([[:space:]]|$)/= /g;"
             "s/[[:space:]]+$//;"
             "s/=[[:space:]]+/= /g"
             "}' '%s'",
             priv_prefix(), esc, esc, PACMAN_CONF);
    run_cmd(cmd);
}

int cmd_deselect(const char *pkg) {
    if (!valid_pkgname(pkg)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET, pkg);
        return 0;
    }

    if (!is_in_world(pkg))
        fprintf(stderr, COLOR_YELLOW
                "[!] %s is not in the world set; unlocking anyway.\n" COLOR_RESET, pkg);

    printf(COLOR_BLUE ">>> [1/2] Unlocking %s in pacman.conf...\n" COLOR_RESET, pkg);
    unlock_pacman_pkg(pkg);

    if (is_kernel(pkg)) {
        char headers[256];
        xsnprintf(headers, sizeof(headers), "%s-headers", pkg);
        unlock_pacman_pkg(headers);
    }

    printf(COLOR_BLUE ">>> [2/2] Removing %s from the world set...\n" COLOR_RESET, pkg);
    remove_from_world(pkg);

    printf(COLOR_GREEN "[+] %s deselected. It stays installed, and pacman will\n"
           "    manage it again from the official repositories.\n" COLOR_RESET, pkg);
    return 1;
}

int cmd_unmerge(const char *pkg) {
    char cmd[1024];

    if (!valid_pkgname(pkg)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET, pkg);
        return 0;
    }

    printf(COLOR_BLUE ">>> [1/3] Unmerging %s via pacman...\n" COLOR_RESET, pkg);

    /* makepkg's debug option produces a companion <pkg>-debug package. It is
       not a dependency, so pacman -Rns leaves it behind as an orphan. */
    char dbg[256];
    char check[512];
    int have_debug;

    xsnprintf(dbg, sizeof(dbg), "%s-debug", pkg);
    xsnprintf(check, sizeof(check), "pacman -Qq '%s'", dbg);
    have_debug = (run_cmd_quiet(check) == 0);

    if (have_debug)
        xsnprintf(cmd, sizeof(cmd), "%spacman -Rns '%s' '%s'%s",
                 priv_prefix(), pkg, dbg, get_noconfirm() ? " --noconfirm" : "");
    else
        xsnprintf(cmd, sizeof(cmd), "%spacman -Rns '%s'%s",
                 priv_prefix(), pkg, get_noconfirm() ? " --noconfirm" : "");

    if (run_cmd(cmd) != 0) {
        fprintf(stderr, COLOR_RED "[-] Unmerge failed.\n" COLOR_RESET);
        return 0;
    }

    printf(COLOR_BLUE ">>> [2/3] Unlocking %s in pacman.conf...\n" COLOR_RESET, pkg);
    unlock_pacman_pkg(pkg);

    /* Kernels get a companion "<pkg>-headers" lock at build time; remove it
       too, otherwise it stays in IgnorePkg forever. */
    if (is_kernel(pkg)) {
        char headers[256];
        xsnprintf(headers, sizeof(headers), "%s-headers", pkg);
        unlock_pacman_pkg(headers);
    }

    printf(COLOR_BLUE ">>> [3/3] Cleaning up world file and build directory...\n" COLOR_RESET);
    remove_from_world(pkg);

    xsnprintf(cmd, sizeof(cmd), "rm -rf '%s/%s'", BUILD_DIR, pkg);
    run_cmd(cmd);

    printf(COLOR_GREEN "[+] %s successfully unmerged.\n" COLOR_RESET, pkg);
    return 1;
}
