/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <fcntl.h>
#include <signal.h>
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

/* Paths kept in file scope so the SIGINT handler can put the old build tree
   back without allocating anything. */
static char g_target[768];
static char g_backup[768];
static volatile sig_atomic_t g_have_backup = 0;
static volatile sig_atomic_t g_interrupted = 0;

/* Async-signal-safe: rename(2) and write(2) only. */
static void restore_on_signal(int sig) {
    (void)sig;
    g_interrupted = 1;
    if (g_have_backup) {
        static const char msg[] = "\n[!] Interrupted - restoring previous build tree...\n";
        ssize_t n = write(STDERR_FILENO, msg, sizeof(msg) - 1);
        (void)n;
        rename(g_backup, g_target);
        g_have_backup = 0;
    }
    _exit(130);
}

static void arm_signals(void) {
    struct sigaction sa;
    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = restore_on_signal;
    sigemptyset(&sa.sa_mask);
    sigaction(SIGINT, &sa, NULL);
    sigaction(SIGTERM, &sa, NULL);
    sigaction(SIGHUP, &sa, NULL);
}

/* Moves an existing build tree aside so the package is genuinely recompiled
   from a clean checkout, keeping the old one recoverable. */
static int backup_existing(const char *pkg) {
    snprintf(g_target, sizeof(g_target), "%s/%s", BUILD_DIR, pkg);
    snprintf(g_backup, sizeof(g_backup), "%s/%s.bak", BACKUP_DIR, pkg);

    if (!dir_exists(g_target))
        return 1;

    char cmd[1700];
    if (dir_exists(g_backup)) {
        snprintf(cmd, sizeof(cmd), "rm -rf '%s'", g_backup);
        run_cmd_quiet(cmd);
    }

    printf(COLOR_YELLOW "[!] Existing build tree found for %s.\n" COLOR_RESET, pkg);
    printf("    Backing it up and removing it so the package is rebuilt from scratch.\n");

    if (rename(g_target, g_backup) != 0) {
        /* Different filesystem, or a permissions problem: fall back to a copy. */
        snprintf(cmd, sizeof(cmd), "cp -a '%s' '%s' && rm -rf '%s'",
                 g_target, g_backup, g_target);
        if (run_cmd_quiet(cmd) != 0) {
            fprintf(stderr, COLOR_RED
                    "[-] Could not move %s aside; refusing to destroy it.\n" COLOR_RESET,
                    g_target);
            return 0;
        }
    }

    g_have_backup = 1;
    printf(COLOR_GREEN "[+] Backup kept at %s\n" COLOR_RESET, g_backup);
    return 1;
}

static void restore_backup(void) {
    if (!g_have_backup)
        return;

    char cmd[1700];
    fprintf(stderr, COLOR_YELLOW "[!] Restoring previous build tree...\n" COLOR_RESET);

    snprintf(cmd, sizeof(cmd), "rm -rf '%s'", g_target);
    run_cmd_quiet(cmd);

    if (rename(g_backup, g_target) != 0) {
        snprintf(cmd, sizeof(cmd), "cp -a '%s' '%s' && rm -rf '%s'",
                 g_backup, g_target, g_backup);
        run_cmd_quiet(cmd);
    }

    g_have_backup = 0;
    fprintf(stderr, COLOR_GREEN "[+] Previous build tree restored to %s\n" COLOR_RESET,
            g_target);
}

static void discard_backup(void) {
    if (!g_have_backup)
        return;

    char cmd[900];
    snprintf(cmd, sizeof(cmd), "rm -rf '%s'", g_backup);
    run_cmd_quiet(cmd);
    g_have_backup = 0;
}

int fetch_sources(const char *pkg) {
    char path[512];
    char cmd[1024];

    snprintf(path, sizeof(path), "%s/%s", BUILD_DIR, pkg);

    if (chdir(BUILD_DIR) != 0) {
        fprintf(stderr, COLOR_RED "[-] Cannot change directory to %s\n" COLOR_RESET, BUILD_DIR);
        return 0;
    }

    /* Always start from a clean checkout: an existing tree is moved to
       BACKUP_DIR and deleted, so the package is genuinely recompiled rather
       than reusing stale sources or a prebuilt .pkg.tar.zst. The backup is
       put back if anything fails or the user interrupts. */
    if (!backup_existing(pkg))
        return 0;

    printf("Searching in official Arch repositories...\n");
    snprintf(cmd, sizeof(cmd),
             "pkgctl repo clone --protocol=https '%s' 2>'%s/.archtoo-fetch.log'",
             pkg, BUILD_DIR);

    if (run_as_user(cmd, NULL) == 0 && dir_exists(path))
        return 1;

    printf(COLOR_YELLOW "[!] Not found in official repos. Trying AUR...\n" COLOR_RESET);
    snprintf(cmd, sizeof(cmd),
             "git clone 'https://aur.archlinux.org/%s.git' 2>>'%s/.archtoo-fetch.log'",
             pkg, BUILD_DIR);

    if (run_as_user(cmd, NULL) == 0 && dir_exists(path))
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
        run_as_user(cmd, NULL);
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

    /* makepkg refuses to run as root, so under sudo this drops back to the
       invoking user. The environment has to be rebuilt inside that shell
       because sudo does not carry it across. */
    char env_block[512];
    snprintf(env_block, sizeof(env_block),
             "export KCFLAGS='%s'\n"
             "export KCPPFLAGS='%s'\n"
             "export MAKEFLAGS='-j%ld'\n",
             DEFAULT_KCFLAGS, DEFAULT_KCFLAGS, get_cpu_cores());

    int rc = run_as_user(cmd, env_block);
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

    snprintf(cmd, sizeof(cmd), "%scp -n '%s' '%s.archtoo.bak'",
             priv_prefix(), PACMAN_CONF, PACMAN_CONF);
    run_cmd_quiet(cmd);

    /* Three cases, in order:
         1. an active  "IgnorePkg = ..."  line   -> append to it
         2. the stock  "#IgnorePkg   ="   line   -> uncomment, then append
            (note the padding: the old 's/^#IgnorePkg =/' never matched it)
         3. neither                              -> insert under [options]   */
    snprintf(cmd, sizeof(cmd),
             "if grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=' '%s'; then "
               "%ssed -i -E '/^[[:space:]]*IgnorePkg[[:space:]]*=/{ s/[[:space:]]*$//; s/$/ %s/ }' '%s'; "
             "elif grep -qE '^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=' '%s'; then "
               "%ssed -i -E '0,/^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=/{ "
               "/^[[:space:]]*#[[:space:]]*IgnorePkg[[:space:]]*=/{ s/^[[:space:]]*#[[:space:]]*//; "
               "s/[[:space:]]*$//; s/$/ %s/ } }' '%s'; "
             "else "
               "%ssed -i '/^\\[options\\]/a IgnorePkg = %s' '%s'; "
             "fi",
             PACMAN_CONF, priv_prefix(), pkg, PACMAN_CONF,
             PACMAN_CONF, priv_prefix(), pkg, PACMAN_CONF,
             priv_prefix(), pkg, PACMAN_CONF);

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

    arm_signals();
    g_have_backup = 0;

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
    if (ok) {
        /* Build succeeded: the old tree is no longer needed. */
        discard_backup();
    } else {
        /* Anything went wrong -- put the previous build tree back exactly
           where it was. */
        restore_backup();
    }

    if (cwd >= 0) {
        if (fchdir(cwd) != 0) { /* the old cwd may be gone; harmless */ }
        close(cwd);
    }
    return ok;
}
