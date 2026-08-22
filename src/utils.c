/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <ctype.h>
#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "../headers/utils.h"
#include "../headers/config.h"
#include "../headers/colors.h"

static int  g_noconfirm = 0;
static long g_jobs = 0;
static int  g_resume = 0;
static int  g_import_keys = 1;
static int  g_inhibit = 1;
static int  g_sync = 1;

void set_noconfirm(int v) { g_noconfirm = v; }
int  get_noconfirm(void)  { return g_noconfirm; }

void set_resume(int v) { g_resume = v; }
int  get_resume(void)  { return g_resume; }

void set_import_keys(int v) { g_import_keys = v; }
int  get_import_keys(void)  { return g_import_keys; }

void set_inhibit(int v) { g_inhibit = v; }
int  get_inhibit(void)  { return g_inhibit; }

void set_sync(int v) { g_sync = v; }
int  get_sync(void)  { return g_sync; }

void set_jobs(long n) { g_jobs = n; }

/* An explicit --jobs wins; otherwise use every core. On a memory-tight
   machine -j<cores> is often the wrong default: each parallel rustc or
   C++ TU can hold gigabytes, and the LTO link at the end is one huge
   single process. */
long get_jobs(void) {
    return (g_jobs > 0) ? g_jobs : get_cpu_cores();
}

int run_cmd(const char *cmd) {
    int st = system(cmd);
    if (st == -1)
        return -1;
    if (WIFSIGNALED(st))
        return 128 + WTERMSIG(st);
    return WIFEXITED(st) ? WEXITSTATUS(st) : -1;
}

int run_cmd_quiet(const char *cmd) {
    char buf[2048];
    if (snprintf(buf, sizeof(buf), "%s >/dev/null 2>&1", cmd) >= (int)sizeof(buf))
        return -1;
    return run_cmd(buf);
}

int file_exists(const char *path) {
    struct stat st;
    return (stat(path, &st) == 0) && S_ISREG(st.st_mode);
}

int dir_exists(const char *path) {
    struct stat st;
    return (stat(path, &st) == 0) && S_ISDIR(st.st_mode);
}

int valid_pkgname(const char *s) {
    if (!s || !*s)
        return 0;
    if (*s == '-' || *s == '.')
        return 0;
    if (strlen(s) > 128)
        return 0;
    for (const char *p = s; *p; p++) {
        unsigned char c = (unsigned char)*p;
        if (!(islower(c) || isdigit(c) || strchr("@._+-", c)))
            return 0;
    }
    return 1;
}

int regex_escape(const char *in, char *out, size_t n) {
    size_t j = 0;
    for (const char *p = in; *p; p++) {
        if (strchr(".^$*+?()[]{}|/\\", *p)) {
            if (j + 2 >= n) return 0;
            out[j++] = '\\';
        } else if (j + 1 >= n) {
            return 0;
        }
        out[j++] = *p;
    }
    if (j >= n) return 0;
    out[j] = '\0';
    return 1;
}

/* Resolves the real invoking user, even under sudo/su. */
const char *build_user(void) {
    const char *u = getenv("SUDO_USER");
    if (u && *u)
        return u;
    struct passwd *pw = getpwuid(getuid());
    return (pw && pw->pw_name) ? pw->pw_name : NULL;
}

const char *priv_prefix(void) {
    return (geteuid() == 0) ? "" : "sudo ";
}

int have_cmd(const char *name) {
    char cmd[512];
    snprintf(cmd, sizeof(cmd), "command -v '%s'", name);
    return run_cmd_quiet(cmd) == 0;
}

void fix_owner(const char *path) {
    if (geteuid() != 0)
        return;

    const char *user = build_user();
    if (!user)
        return;

    char cmd[1024];
    snprintf(cmd, sizeof(cmd), "chown '%s' '%s'", user, path);
    run_cmd_quiet(cmd);
}

/* makepkg refuses to run as root, so when emerge is invoked with sudo the
   build steps are handed back to the unprivileged user, the same way
   Portage drops to the "portage" user. */
int run_as_user(const char *cmd, const char *extra_env) {
    if (geteuid() != 0) {
        if (!extra_env || !*extra_env)
            return run_cmd(cmd);
        char buf[4096];
        if (snprintf(buf, sizeof(buf), "%s%s", extra_env, cmd) >= (int)sizeof(buf))
            return -1;
        return run_cmd(buf);
    }

    const char *user = build_user();
    if (!user) {
        fprintf(stderr, COLOR_RED
                "[-] Running as root with no SUDO_USER; cannot find an "
                "unprivileged user to build as.\n" COLOR_RESET);
        return -1;
    }

    /* Hand the command over via a script so nothing has to survive two
       layers of shell quoting. */
    char script[600];
    snprintf(script, sizeof(script), "%s/.archtoo-step-%ld.sh",
             EMERGE_DIR, (long)getpid());

    FILE *f = fopen(script, "w");
    if (!f) {
        fprintf(stderr, COLOR_RED "[-] Cannot write %s\n" COLOR_RESET, script);
        return -1;
    }
    fprintf(f, "#!/bin/sh\n%s%s\n", extra_env ? extra_env : "", cmd);
    fclose(f);
    chmod(script, 0755);

    fix_owner(script);

    /* sudo keeps the current working directory, which makepkg needs. */
    char cmd_buf[1024];
    snprintf(cmd_buf, sizeof(cmd_buf), "sudo -u '%s' -- /bin/sh '%s'", user, script);

    int rc = run_cmd(cmd_buf);
    unlink(script);
    return rc;
}

int init_system(void) {
    char cmd[1024];

    if (!dir_exists(BUILD_DIR) || !dir_exists(BACKUP_DIR)) {
        snprintf(cmd, sizeof(cmd), "%smkdir -p '%s' '%s'",
                 priv_prefix(), BUILD_DIR, BACKUP_DIR);
        if (run_cmd(cmd) != 0) {
            fprintf(stderr, COLOR_RED "[-] Could not create %s\n" COLOR_RESET, EMERGE_DIR);
            return 0;
        }
    }

    /* Repair ownership every run, not just on first creation: a directory left
       behind as root:root made the world file silently unwritable. */
    /* Under sudo the tree must belong to the build user, not to root, or
       makepkg cannot write to it after we drop privileges. */
    if (geteuid() == 0 || access(EMERGE_DIR, W_OK) != 0) {
        const char *user = build_user();
        if (user && valid_pkgname(user) == 0) {
            /* usernames may contain characters valid_pkgname rejects; only
               allow a conservative set through to the shell. */
            for (const char *p = user; *p; p++) {
                unsigned char c = (unsigned char)*p;
                if (!(isalnum(c) || strchr("._-", c))) { user = NULL; break; }
            }
        }
        if (user) {
            snprintf(cmd, sizeof(cmd), "%schown -R '%s' '%s'",
                     priv_prefix(), user, EMERGE_DIR);
            run_cmd_quiet(cmd);
        }
    }

    if (!file_exists(WORLD_FILE)) {
        FILE *f = fopen(WORLD_FILE, "a");
        if (!f) {
            fprintf(stderr, COLOR_RED "[-] Cannot write world file %s\n" COLOR_RESET, WORLD_FILE);
            return 0;
        }
        fclose(f);
    }

    if (geteuid() == 0) {
        const char *user = build_user();
        if (user) {
            snprintf(cmd, sizeof(cmd), "chown '%s' '%s'", user, WORLD_FILE);
            run_cmd_quiet(cmd);
        }
    }

    if (access(WORLD_FILE, W_OK) != 0) {
        fprintf(stderr, COLOR_RED "[-] World file %s is not writable.\n" COLOR_RESET, WORLD_FILE);
        return 0;
    }

    return 1;
}

const char *get_editor(void) {
    const char *editor = getenv("EDITOR");
    return (editor && *editor) ? editor : "nano";
}

long get_cpu_cores(void) {
    long cores = sysconf(_SC_NPROCESSORS_ONLN);
    return (cores > 0) ? cores : 1;
}

void set_build_env(void) {
    char makeflags[64];
    snprintf(makeflags, sizeof(makeflags), "-j%ld", get_jobs());

    /* Kernel PKGBUILDs read KCFLAGS/KCPPFLAGS from the environment, so these
       still matter. CFLAGS/CXXFLAGS/MAKEFLAGS do NOT survive makepkg -- it
       sources /etc/makepkg.conf and overwrites them. Those go through
       write_makepkg_conf() and makepkg --config instead. */
    setenv("KCFLAGS", DEFAULT_KCFLAGS, 1);
    setenv("KCPPFLAGS", DEFAULT_KCFLAGS, 1);
    setenv("MAKEFLAGS", makeflags, 1);
}

int write_makepkg_conf(char *path_out, size_t n) {
    if (snprintf(path_out, n, "%s/makepkg.archtoo.conf", EMERGE_DIR) >= (int)n)
        return 0;

    FILE *f = fopen(path_out, "w");
    if (!f) {
        fprintf(stderr, COLOR_RED "[-] Cannot write %s\n" COLOR_RESET, path_out);
        return 0;
    }

    fprintf(f,
            "# Generated by archtoo -- do not edit, it is rewritten every build.\n"
            "source /etc/makepkg.conf\n"
            "CFLAGS=\"%s\"\n"
            "CXXFLAGS=\"%s\"\n"
            "LDFLAGS=\"${LDFLAGS}\"\n"
            "RUSTFLAGS=\"-C opt-level=3 -C target-cpu=native\"\n"
            "MAKEFLAGS=\"-j%ld\"\n",
            DEFAULT_CFLAGS, DEFAULT_CXXFLAGS, get_jobs());

    fclose(f);
    fix_owner(path_out);
    return 1;
}

int ask_yes_no(const char *question, int default_yes) {
    char reply[64];

    if (g_noconfirm || !isatty(STDIN_FILENO)) {
        printf("%s [%s]: %s (auto)\n", question, default_yes ? "Y/n" : "y/N",
               default_yes ? "yes" : "no");
        return default_yes;
    }

    printf("%s [%s]: ", question, default_yes ? "Y/n" : "y/N");
    fflush(stdout);

    if (!fgets(reply, sizeof(reply), stdin))
        return default_yes;

    /* Drain the rest of an over-long line so it does not answer the next
       prompt for us. */
    if (!strchr(reply, '\n')) {
        int c;
        while ((c = getchar()) != '\n' && c != EOF)
            ;
    }

    if (reply[0] == '\n' || reply[0] == '\r' || reply[0] == '\0')
        return default_yes;

    return (reply[0] == 'y' || reply[0] == 'Y');
}
