/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "../headers/build.h"
#include "../headers/kernel.h"
#include "../headers/world.h"
#include "../headers/utils.h"
#include "../headers/config.h"
#include "../headers/colors.h"

int fetch_sources(const char *pkg) {
    char path[512];
    char cmd[1024];

    snprintf(path, sizeof(path), "%s/%s", BUILD_DIR, pkg);

    if (chdir(BUILD_DIR) != 0) {
        fprintf(stderr, COLOR_RED "[-] Cannot change directory to %s\n" COLOR_RESET, BUILD_DIR);
        return 0;
    }

    if (dir_exists(path)) {
        char git_dir[600];
        snprintf(git_dir, sizeof(git_dir), "%s/.git", path);

        if (!dir_exists(git_dir)) {
            fprintf(stderr, COLOR_YELLOW
                    "[!] %s exists but is not a git checkout (leftover from a failed clone).\n"
                    COLOR_RESET, path);
            if (!ask_yes_no("Remove it and clone again", 0)) {
                fprintf(stderr, COLOR_RED "[-] Cannot continue with a broken checkout.\n" COLOR_RESET);
                return 0;
            }
            snprintf(cmd, sizeof(cmd), "rm -rf '%s'", path);
            run_cmd(cmd);
        } else {
            printf("Existing build directory found. Pulling updates via git...\n");
            snprintf(cmd, sizeof(cmd), "git -C '%s' pull --ff-only", path);
            if (run_cmd(cmd) != 0) {
                fprintf(stderr, COLOR_YELLOW
                        "[!] git pull failed -- the checkout is dirty or unreachable.\n"
                        COLOR_RESET);
                if (!ask_yes_no("Discard local changes and re-clone", 0)) {
                    fprintf(stderr, COLOR_RED
                            "[-] Refusing to build stale sources.\n" COLOR_RESET);
                    return 0;
                }
                snprintf(cmd, sizeof(cmd), "rm -rf '%s'", path);
                run_cmd(cmd);
            } else {
                return 1;
            }
        }
    }

    printf("Searching in official Arch repositories...\n");
    snprintf(cmd, sizeof(cmd),
             "pkgctl repo clone --protocol=https '%s' 2>'%s/.archtoo-fetch.log'",
             pkg, BUILD_DIR);

    if (run_cmd(cmd) == 0 && dir_exists(path))
        return 1;

    printf(COLOR_YELLOW "[!] Not found in official repos. Trying AUR...\n" COLOR_RESET);
    snprintf(cmd, sizeof(cmd),
             "git clone 'https://aur.archlinux.org/%s.git' 2>>'%s/.archtoo-fetch.log'",
             pkg, BUILD_DIR);

    if (run_cmd(cmd) == 0 && dir_exists(path))
        return 1;

    fprintf(stderr, COLOR_RED "[-] Package '%s' not found in Arch repos or AUR.\n" COLOR_RESET, pkg);
    fprintf(stderr, COLOR_YELLOW "    Details: %s/.archtoo-fetch.log\n" COLOR_RESET, BUILD_DIR);
    return 0;
}

int compile_package(const char *pkg) {
    char path[512];
    char conf[512];
    char cmd[1024];

    snprintf(path, sizeof(path), "%s/%s", BUILD_DIR, pkg);

    if (chdir(path) != 0) {
        fprintf(stderr, COLOR_RED "[-] Cannot enter %s\n" COLOR_RESET, path);
        return 0;
    }

    if (!file_exists("PKGBUILD")) {
        fprintf(stderr, COLOR_RED "[-] No PKGBUILD in %s\n" COLOR_RESET, path);
        return 0;
    }

    printf(COLOR_BLUE ">>> Edit PKGBUILD for custom flags?\n" COLOR_RESET);
    if (ask_yes_no("Open in editor", 0)) {
        snprintf(cmd, sizeof(cmd), "%s PKGBUILD", get_editor());
        run_cmd(cmd);
    }

    set_build_env();

    /* makepkg sources /etc/makepkg.conf and clobbers any exported CFLAGS,
       so the native flags have to be handed over as a config file. */
    if (!write_makepkg_conf(conf, sizeof(conf)))
        return 0;

    printf(COLOR_BLUE ">>> Compiling with makepkg (%s, -j%ld)...\n" COLOR_RESET,
           DEFAULT_CFLAGS, get_cpu_cores());

    /* -f is required: without it makepkg finds a leftover .pkg.tar.zst and
       reinstalls it instead of compiling, so the whole point of the tool
       (and of -U in particular) is silently skipped. */
    snprintf(cmd, sizeof(cmd), "makepkg -sif --config '%s'%s",
             conf, get_noconfirm() ? " --noconfirm" : "");

    int rc = run_cmd(cmd);
    if (rc == 130 || rc == 131) {
        fprintf(stderr, COLOR_RED "\n[-] Build interrupted by user.\n" COLOR_RESET);
        return 0;
    }
    if (rc != 0) {
        fprintf(stderr, COLOR_RED "[-] Compilation failed (exit %d).\n" COLOR_RESET, rc);
        return 0;
    }

    return 1;
}

int lock_pacman_pkg(const char *pkg) {
    char esc[320];
    char cmd[2048];

    if (!regex_escape(pkg, esc, sizeof(esc)))
        return 0;

    /* Only an *active* IgnorePkg line counts -- the old check also matched
       the commented-out template line. */
    snprintf(cmd, sizeof(cmd),
             "grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=.*([[:space:]]|=)[[:space:]]*%s([[:space:]]|$)' '%s'",
             esc, PACMAN_CONF);

    if (run_cmd_quiet(cmd) == 0) {
        printf(COLOR_GREEN "[+] %s is already locked in IgnorePkg\n" COLOR_RESET, pkg);
        return 1;
    }

    snprintf(cmd, sizeof(cmd), "sudo cp -n '%s' '%s.archtoo.bak'", PACMAN_CONF, PACMAN_CONF);
    run_cmd_quiet(cmd);

    /* Three cases, in order:
         1. an active  "IgnorePkg = ..."  line   -> append to it
         2. the stock  "#IgnorePkg   ="   line   -> uncomment, then append
            (note the padding: the old 's/^#IgnorePkg =/' never matched it)
         3. neither                              -> insert under [options]   */
    snprintf(cmd, sizeof(cmd),
             "if grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=' '%s'; then "
               "sudo sed -i -E '/^[[:space:]]*IgnorePkg[[:space:]]*=/{ s/[[:space:]]*$//; s/$/ %s/ }' '%s'; "
             "elif grep -qE '^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=' '%s'; then "
               "sudo sed -i -E '0,/^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=/{ "
               "/^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=/{ s/^[[:space:]]*#[[:space:]]*//; "
               "s/[[:space:]]*$//; s/$/ %s/ } }' '%s'; "
             "else "
               "sudo sed -i '/^\\[options\\]/a IgnorePkg = %s' '%s'; "
             "fi",
             PACMAN_CONF, pkg, PACMAN_CONF,
             PACMAN_CONF, pkg, PACMAN_CONF,
             pkg, PACMAN_CONF);

    run_cmd(cmd);

    /* Verify instead of assuming -- the previous version reported success
       unconditionally, even when the edit silently did nothing. */
    snprintf(cmd, sizeof(cmd),
             "grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=.*([[:space:]]|=)[[:space:]]*%s([[:space:]]|$)' '%s'",
             esc, PACMAN_CONF);

    if (run_cmd_quiet(cmd) != 0) {
        fprintf(stderr, COLOR_RED
                "[-] Failed to lock %s in %s -- check the file by hand.\n" COLOR_RESET,
                pkg, PACMAN_CONF);
        return 0;
    }

    printf(COLOR_GREEN "[+] %s locked in pacman.conf\n" COLOR_RESET, pkg);
    return 1;
}

void cleanup_build_dir(const char *pkg) {
    printf(COLOR_BLUE ">>> Clean up build directory?\n" COLOR_RESET);

    /* Defaults to no: this is an rm -rf, and it used to answer itself "yes"
       whenever stdin was not a terminal. */
    if (!ask_yes_no("Remove directory", 0)) {
        printf(COLOR_YELLOW "[-] Build directory preserved in %s/%s\n" COLOR_RESET, BUILD_DIR, pkg);
        return;
    }

    /* Step out of the directory before deleting it. */
    if (chdir(BUILD_DIR) != 0)
        return;

    char cmd[600];
    snprintf(cmd, sizeof(cmd), "rm -rf '%s/%s'", BUILD_DIR, pkg);
    run_cmd(cmd);
    printf(COLOR_GREEN "[+] Build directory cleaned up.\n" COLOR_RESET);
}

int cmd_build(const char *pkg) {
    if (!valid_pkgname(pkg)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET, pkg);
        return 0;
    }

    int cwd = open(".", O_RDONLY | O_CLOEXEC);
    int ok = 0;

    /* Kernels run an extra hook step; number the steps accordingly instead
       of printing 1, 2, 4, 5 for ordinary packages. */
    const int kernel = is_kernel(pkg);
    const int total = kernel ? 5 : 4;
    int step = 1;

    printf(COLOR_BLUE ">>> [%d/%d] Fetching sources for %s...\n" COLOR_RESET,
           step++, total, pkg);
    if (!fetch_sources(pkg))
        goto out;

    printf(COLOR_BLUE ">>> [%d/%d] Compiling package...\n" COLOR_RESET, step++, total);
    if (!compile_package(pkg))
        goto out;

    if (kernel) {
        char headers[256];
        printf(COLOR_BLUE ">>> [%d/%d] Running kernel hooks...\n" COLOR_RESET, step++, total);
        run_kernel_hooks(pkg);

        snprintf(headers, sizeof(headers), "%s-headers", pkg);
        lock_pacman_pkg(headers);
    }

    printf(COLOR_BLUE ">>> [%d/%d] Locking in pacman.conf...\n" COLOR_RESET, step++, total);
    lock_pacman_pkg(pkg);
    add_to_world(pkg);

    printf(COLOR_BLUE ">>> [%d/%d] Cleaning up...\n" COLOR_RESET, step++, total);
    cleanup_build_dir(pkg);

    printf(COLOR_GREEN "\n>>> DONE! %s is custom built and installed.\n" COLOR_RESET, pkg);

    if (kernel)
        printf(COLOR_YELLOW "[!] Reboot to load your new kernel.\n" COLOR_RESET);

    ok = 1;

out:
    if (cwd >= 0) {
        if (fchdir(cwd) != 0) { /* the old cwd may be gone; harmless */ }
        close(cwd);
    }
    return ok;
}
