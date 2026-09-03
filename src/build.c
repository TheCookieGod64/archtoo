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
    xsnprintf(g_target, sizeof(g_target), "%s/%s", BUILD_DIR, pkg);
    xsnprintf(g_backup, sizeof(g_backup), "%s/%s.bak", BACKUP_DIR, pkg);

    if (!dir_exists(g_target))
        return 1;

    char cmd[1700];
    if (dir_exists(g_backup)) {
        xsnprintf(cmd, sizeof(cmd), "rm -rf '%s'", g_backup);
        run_cmd_quiet(cmd);
    }

    printf(COLOR_YELLOW "[!] Existing build tree found for %s.\n" COLOR_RESET, pkg);
    printf("    Backing it up and removing it so the package is rebuilt from scratch.\n");

    if (rename(g_target, g_backup) != 0) {
        /* Different filesystem, or a permissions problem: fall back to a copy. */
        xsnprintf(cmd, sizeof(cmd), "cp -a '%s' '%s' && rm -rf '%s'",
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

    xsnprintf(cmd, sizeof(cmd), "rm -rf '%s'", g_target);
    run_cmd_quiet(cmd);

    if (rename(g_backup, g_target) != 0) {
        xsnprintf(cmd, sizeof(cmd), "cp -a '%s' '%s' && rm -rf '%s'",
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
    xsnprintf(cmd, sizeof(cmd), "rm -rf '%s'", g_backup);
    run_cmd_quiet(cmd);
    g_have_backup = 0;
}

/* The AUR git server hands out an EMPTY repository for any well-formed name,
   even one that does not exist, so "the clone worked" is not the same as
   "the package exists". Only a PKGBUILD proves it. */
static int has_pkgbuild(const char *dir) {
    char p[700];
    xsnprintf(p, sizeof(p), "%s/PKGBUILD", dir);
    return file_exists(p);
}

int fetch_sources(const char *pkg) {
    char path[512];
    char cmd[1024];

    xsnprintf(path, sizeof(path), "%s/%s", BUILD_DIR, pkg);

    if (chdir(BUILD_DIR) != 0) {
        fprintf(stderr, COLOR_RED "[-] Cannot change directory to %s\n" COLOR_RESET, BUILD_DIR);
        return 0;
    }

    /* --resume: keep the existing tree so an interrupted build can carry on
       from the object files it already produced. */
    if (get_resume()) {
        char git_dir[600];
        xsnprintf(git_dir, sizeof(git_dir), "%s/.git", path);

        if (dir_exists(path)) {
            printf(COLOR_GREEN "[+] Resuming in existing build tree %s\n" COLOR_RESET, path);
            if (!dir_exists(git_dir))
                fprintf(stderr, COLOR_YELLOW
                        "[!] Not a git checkout; resuming anyway.\n" COLOR_RESET);
            return 1;
        }

        fprintf(stderr, COLOR_YELLOW
                "[!] --resume given but no build tree exists for %s; "
                "starting fresh.\n" COLOR_RESET, pkg);
    }

    /* Otherwise always start from a clean checkout: an existing tree is moved
       to BACKUP_DIR and deleted, so the package is genuinely recompiled
       rather than reusing stale sources or a prebuilt .pkg.tar.zst. The
       backup is put back if anything fails or the user interrupts. */
    if (!backup_existing(pkg))
        return 0;

    printf("Searching in official Arch repositories...\n");
    xsnprintf(cmd, sizeof(cmd),
             "pkgctl repo clone --protocol=https '%s' 2>'%s/.archtoo-fetch.log'",
             pkg, BUILD_DIR);

    if (run_as_user(cmd, NULL) == 0 && has_pkgbuild(path))
        return 1;

    printf(COLOR_YELLOW "[!] Not found in official repos. Trying AUR...\n" COLOR_RESET);
    xsnprintf(cmd, sizeof(cmd),
             "git clone 'https://aur.archlinux.org/%s.git' 2>>'%s/.archtoo-fetch.log'",
             pkg, BUILD_DIR);

    if (run_as_user(cmd, NULL) == 0 && has_pkgbuild(path))
        return 1;

    /* Clean up the empty checkout the AUR just handed us. */
    if (dir_exists(path) && !has_pkgbuild(path)) {
        xsnprintf(cmd, sizeof(cmd), "rm -rf '%s'", path);
        run_cmd_quiet(cmd);
    }

    fprintf(stderr, COLOR_RED "[-] Package '%s' not found in Arch repos or AUR.\n" COLOR_RESET, pkg);
    fprintf(stderr, COLOR_YELLOW "    Details: %s/.archtoo-fetch.log\n" COLOR_RESET, BUILD_DIR);
    return 0;
}

/* PKGBUILDs that verify upstream signatures list the signing keys in
   validpgpkeys. If those keys are not in the user's keyring, makepkg stops
   with "One or more PGP signatures could not be verified", which is the most
   common way an otherwise-fine AUR build fails. Import them up front.

   The array is parsed with awk rather than by sourcing the PKGBUILD, so no
   code from it runs at this point. */
static void import_pgp_keys(void) {
    if (!get_import_keys() || !file_exists("PKGBUILD"))
        return;

    char cmd[2048];
    xsnprintf(cmd, sizeof(cmd),
        "keys=$(awk '/^[[:space:]]*validpgpkeys=\\(/,/\\)/' PKGBUILD "
        "| grep -oE '[0-9A-Fa-f]{40}|[0-9A-Fa-f]{16}' | sort -u); "
        "[ -z \"$keys\" ] && exit 0; "
        "for k in $keys; do "
        "  if gpg --list-keys \"$k\" >/dev/null 2>&1; then "
        "    echo \"    already have $k\"; "
        "  else "
        "    echo \"    importing $k\"; "
        "    gpg --keyserver keyserver.ubuntu.com --recv-keys \"$k\" >/dev/null 2>&1 "
        "      || gpg --keyserver keys.openpgp.org --recv-keys \"$k\" >/dev/null 2>&1 "
        "      || echo \"    [!] could not fetch $k\"; "
        "  fi; "
        "done");

    printf(COLOR_BLUE ">>> Checking PGP signing keys...\n" COLOR_RESET);
    run_as_user(cmd, NULL);
}

int compile_package(const char *pkg) {
    char path[512];
    char conf[512];
    /* cmd holds the systemd-inhibit wrapper (~150 chars of prefix) around
       makepkg_cmd, so it needs real headroom; a truncated shell command
       still runs, it just runs the wrong thing. */
    char cmd[2048];

    xsnprintf(path, sizeof(path), "%s/%s", BUILD_DIR, pkg);

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
        xsnprintf(cmd, sizeof(cmd), "%s PKGBUILD", get_editor());
        run_as_user(cmd, NULL);
    }

    import_pgp_keys();

    set_build_env();

    /* makepkg sources /etc/makepkg.conf and clobbers any exported CFLAGS,
       so the native flags have to be handed over as a config file. */
    if (!write_makepkg_conf(conf, sizeof(conf)))
        return 0;

    printf(COLOR_BLUE ">>> Compiling with makepkg (%s, -j%ld)%s...\n" COLOR_RESET,
           DEFAULT_CFLAGS, get_jobs(), get_resume() ? " [resuming]" : "");

    /* -f is required: without it makepkg finds a leftover .pkg.tar.zst and
       reinstalls it instead of compiling, so the whole point of the tool
       (and of -U in particular) is silently skipped. */
    /* -e (--noextract) is what actually makes a resume work: without it
       makepkg re-extracts $srcdir and throws away every object file. */
    char makepkg_cmd[1024];
    /* Do not pass -i: makepkg would invoke sudo from the unprivileged build
       process, which has a separate sudo credential scope. Archtoo installs
       the finished archives itself as root immediately afterwards. */
    xsnprintf(makepkg_cmd, sizeof(makepkg_cmd), "makepkg -sf%s --config '%s'%s",
             get_resume() ? "e" : "", conf,
             use_noconfirm() ? " --noconfirm" : "");

    /* Multi-hour builds are routinely lost to idle suspend. Hold the machine
       awake for exactly as long as the compile runs. */
    /* Presence is not enough: systemd-inhibit exists but returns "Access
       denied" without a logind session (containers, some SSH sessions,
       restrictive polkit). Wrapping the build in something that fails would
       kill the build outright, so probe it with a no-op first. */
    int inhibit = 0;
    if (get_inhibit() && have_cmd("systemd-inhibit")) {
        inhibit = (run_cmd_quiet("systemd-inhibit --what=idle --who=archtoo "
                                 "--why=probe true") == 0);
        if (!inhibit)
            fprintf(stderr, COLOR_YELLOW
                    "[!] systemd-inhibit is present but not usable here "
                    "(no logind session?);\n"
                    "    building without suspend inhibition.\n" COLOR_RESET);
    }

    if (inhibit) {
        printf(COLOR_BLUE ">>> Suspend and idle inhibited for the duration of the build.\n"
               COLOR_RESET);
        xsnprintf(cmd, sizeof(cmd),
                 "systemd-inhibit --what=sleep:idle:handle-lid-switch "
                 "--who=archtoo --why='Compiling %s' --mode=block -- %s",
                 pkg, makepkg_cmd);
    } else {
        xsnprintf(cmd, sizeof(cmd), "%s", makepkg_cmd);
        if (get_inhibit() && !have_cmd("systemd-inhibit"))
            fprintf(stderr, COLOR_YELLOW
                    "[!] systemd-inhibit not found; the machine may suspend mid-build.\n"
                    COLOR_RESET);
    }

    /* makepkg refuses to run as root, so under sudo this drops back to the
       invoking user. The environment has to be rebuilt inside that shell
       because sudo does not carry it across. */
    char env_block[1024];
    xsnprintf(env_block, sizeof(env_block),
             "export KCFLAGS='%s'\n"
             "export KCPPFLAGS='%s'\n"
             "export MAKEFLAGS='-j%ld'\n",
             DEFAULT_KCFLAGS, DEFAULT_KCFLAGS, get_jobs());

    int rc = run_as_user(cmd, env_block);
    if (rc == 130 || rc == 131) {
        fprintf(stderr, COLOR_RED "\n[-] Build interrupted by user.\n" COLOR_RESET);
        return 0;
    }
    if (rc != 0) {
        fprintf(stderr, COLOR_RED "[-] Compilation failed (exit %d).\n" COLOR_RESET, rc);
        return 0;
    }

    /* The main emerge process is root after acquire_sudo() re-executes it.
       Install every split-package archive in one pacman transaction, while
       excluding optional detached signature files. */
    printf(COLOR_BLUE ">>> Installing built package(s) with pacman...\n" COLOR_RESET);
    xsnprintf(cmd, sizeof(cmd),
             "find . -maxdepth 1 -type f -name '*.pkg.tar.*' "
             "! -name '*.sig' -exec pacman -U%s -- {} +",
             use_noconfirm() ? " --noconfirm" : "");
    rc = run_cmd(cmd);
    if (rc != 0) {
        fprintf(stderr, COLOR_RED "[-] Package installation failed (exit %d).\n"
                COLOR_RESET, rc);
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
    xsnprintf(cmd, sizeof(cmd),
             "grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=.*([[:space:]]|=)[[:space:]]*%s([[:space:]]|$)' '%s'",
             esc, PACMAN_CONF);

    if (run_cmd_quiet(cmd) == 0) {
        printf(COLOR_GREEN "[+] %s is already locked in IgnorePkg\n" COLOR_RESET, pkg);
        return 1;
    }

    xsnprintf(cmd, sizeof(cmd), "%scp -n '%s' '%s.archtoo.bak'",
             priv_prefix(), PACMAN_CONF, PACMAN_CONF);
    run_cmd_quiet(cmd);

    /* Three cases, in order:
         1. an active  "IgnorePkg = ..." line   -> append to it
         2. the stock  "#IgnorePkg   ="   line   -> uncomment, then append
            (note the padding: the old 's/^#IgnorePkg =/' never matched it)
         3. neither                              -> insert under [options]
       For case 1 the sed address is 0,/<re>/ -- the range runs from the top
       of the file to the *first* active IgnorePkg line, and the commands are
       re-tested against <re> inside the block so they only fire on that one
       line. A bare 0,/<re>/{ ... } would append the package to every line of
       the file up to the first match (GNU sed applies a { } block to every
       line of the range), and a bare /<re>/{ ... } would append to every
       active IgnorePkg line the file has. Both make pacman.conf uglier on
       each build cycle even though unlock strips them all again. */
    xsnprintf(cmd, sizeof(cmd),
             "if grep -qE '^[[:space:]]*IgnorePkg[[:space:]]*=' '%s'; then "
               "%ssed -i -E '0,/^[[:space:]]*IgnorePkg[[:space:]]*=/{ "
               "/^[[:space:]]*IgnorePkg[[:space:]]*=/{ s/[[:space:]]*$//; s/$/ %s/ } }' '%s'; "
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
    xsnprintf(cmd, sizeof(cmd),
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
    if (get_resume()) {
        printf(COLOR_YELLOW "[-] Build directory kept (--resume): %s/%s\n" COLOR_RESET,
               BUILD_DIR, pkg);
        return;
    }

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
    xsnprintf(cmd, sizeof(cmd), "rm -rf '%s/%s'", BUILD_DIR, pkg);
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
       of printing 1, 2, 4, 5 for ordinary packages. The name check only
       decides the numbering (and whether to scan the archives); the actual
       hooks are gated on the package containing a kernel. */
    const int kernel = is_kernel(pkg);
    const int total = kernel ? 5 : 4;
    int built_kernel = 0;
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

        /* Authoritative test: a package is only a kernel if the built
           archive actually ships usr/lib/modules/<kver>/vmlinuz. This is what
           stops lookalikes (linux-wifi-hotspot, linux-atm, ...) from
           triggering mkinitcpio/GRUB and a bogus -headers lock. */
        built_kernel = pkg_ships_kernel(pkg);
        if (built_kernel) {
            printf(COLOR_BLUE ">>> [%d/%d] Running kernel hooks...\n" COLOR_RESET,
                   step++, total);
            run_kernel_hooks(pkg);

            xsnprintf(headers, sizeof(headers), "%s-headers", pkg);
            lock_pacman_pkg(headers);
        } else {
            fprintf(stderr, COLOR_YELLOW
                    "[!] %s is named like a kernel, but the built package "
                    "contains no\n"
                    "    usr/lib/modules/<kver>/vmlinuz; skipping kernel hooks "
                    "and the -headers lock.\n" COLOR_RESET, pkg);
        }
    }

    printf(COLOR_BLUE ">>> [%d/%d] Locking in pacman.conf...\n" COLOR_RESET, step++, total);
    lock_pacman_pkg(pkg);
    add_to_world(pkg);

    printf(COLOR_BLUE ">>> [%d/%d] Cleaning up...\n" COLOR_RESET, step++, total);
    cleanup_build_dir(pkg);

    printf(COLOR_GREEN "\n>>> DONE! %s is custom built and installed.\n" COLOR_RESET, pkg);

    if (built_kernel)
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
