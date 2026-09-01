/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <pwd.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
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
    /* Must be comfortably larger than the largest command any caller builds
       (lock_pacman_pkg's sed pipeline uses a 2048-byte buffer): xsnprintf
       aborts on truncation, so an undersized wrapper buffer here would turn
       a long-but-valid command into a hard exit. */
    char buf[4608];
    xsnprintf(buf, sizeof(buf), "%s >/dev/null 2>&1", cmd);
    return run_cmd(buf);
}

/* snprintf that never truncates silently: on overflow the caller is about
   to run a *different* command than it thinks, so dying is the only honest
   outcome. The strings this tool formats are all short, so a fire here is a
   genuine bug: a -D override made a path too long for its buffer. */
int xsnprintf(char *buf, size_t n, const char *fmt, ...) {
    va_list ap;

    va_start(ap, fmt);
    int ret = vsnprintf(buf, n, fmt, ap);
    va_end(ap);

    if (ret < 0 || (size_t)ret >= n) {
        fprintf(stderr, COLOR_RED
                "[-] Internal error: formatted output needs %d bytes but only "
                "%zu are available; aborting rather than running a truncated "
                "command or path.\n" COLOR_RESET, ret, n);
        exit(EXIT_FAILURE);
    }
    return ret;
}

/* fopen() with O_NOFOLLOW: see the header. */
FILE *fopen_nofollow(const char *path, const char *mode) {
    int flags;

    switch (mode[0]) {
    case 'r': flags = O_RDONLY; break;
    case 'w': flags = O_WRONLY | O_CREAT | O_TRUNC; break;
    case 'a': flags = O_WRONLY | O_CREAT | O_APPEND; break;
    default:  errno = EINVAL; return NULL;
    }

    int fd = open(path, flags | O_NOFOLLOW, 0644);
    if (fd < 0)
        return NULL;

    FILE *f = fdopen(fd, mode);
    if (!f)
        close(fd);
    return f;
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

static pid_t sudo_keeper = -1;

static void stop_sudo_keeper(void) {
    if (sudo_keeper > 0) {
        kill(sudo_keeper, SIGTERM);
        waitpid(sudo_keeper, NULL, 0);
        sudo_keeper = -1;
    }
}

int acquire_sudo(void) {
    /* "sudo emerge" has already authenticated before this process starts.
       A plain "emerge" deliberately forgets any cached timestamp so every
       invocation asks once, even if sudo was used moments ago. */
    if (geteuid() == 0)
        return 1;

    if (!have_cmd("sudo")) {
        fprintf(stderr, COLOR_RED "[-] sudo is required.\n" COLOR_RESET);
        return 0;
    }

    if (run_cmd("sudo -k && sudo -v") != 0) {
        fprintf(stderr, COLOR_RED "[-] sudo authentication failed.\n" COLOR_RESET);
        return 0;
    }

    sudo_keeper = fork();
    if (sudo_keeper < 0) {
        fprintf(stderr, COLOR_RED
                "[-] Could not start the sudo credential keeper.\n" COLOR_RESET);
        return 0;
    }
    if (sudo_keeper == 0) {
        pid_t parent = getppid();
        for (;;) {
            sleep(50);
            if (getppid() != parent || kill(parent, 0) != 0)
                _exit(0);
            (void)run_cmd_quiet("sudo -n -v");
        }
    }

    atexit(stop_sudo_keeper);
    return 1;
}

int have_cmd(const char *name) {
    char cmd[512];
    xsnprintf(cmd, sizeof(cmd), "command -v '%s'", name);
    return run_cmd_quiet(cmd) == 0;
}

void fix_owner(const char *path) {
    if (geteuid() != 0)
        return;

    const char *user = build_user();
    if (!user)
        return;

    char cmd[1024];
    xsnprintf(cmd, sizeof(cmd), "chown '%s' '%s'", user, path);
    run_cmd_quiet(cmd);
}

/* Unpredictable nonce for step-script names. A hostile process can read
   /proc for the PID, but an 0x-prefixed 32-bit value from /dev/urandom is
   not guessable in time. The O_EXCL|O_NOFOLLOW create below is the real
   guard; the nonce just stops an attacker from burning every candidate
   name in advance. */
static unsigned long step_nonce(void) {
    unsigned char b[4];

    int fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
    if (fd >= 0) {
        ssize_t n = read(fd, b, sizeof(b));
        close(fd);
        if (n == (ssize_t)sizeof(b))
            return ((unsigned long)b[0] << 24) | ((unsigned long)b[1] << 16) |
                   ((unsigned long)b[2] << 8) | (unsigned long)b[3];
    }

    /* No getrandom (or unreadable): mix time, PID and clock. Not strong
       entropy, but O_EXCL|O_NOFOLLOW is what actually keeps us safe. */
    struct timespec ts;
    clock_gettime(CLOCK_REALTIME, &ts);
    return (unsigned long)ts.tv_nsec ^ ((unsigned long)getpid() << 16) ^
           (unsigned long)clock();
}

/* makepkg refuses to run as root, so when emerge is invoked with sudo the
   build steps are handed back to the unprivileged user, the same way
   Portage drops to the "portage" user. */
int run_as_user(const char *cmd, const char *extra_env) {
    if (geteuid() != 0) {
        if (!extra_env || !*extra_env)
            return run_cmd(cmd);
        char buf[4096];
        xsnprintf(buf, sizeof(buf), "%s%s", extra_env, cmd);
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
       layers of shell quoting.

       The script lives in EMERGE_DIR, which init_system() deliberately hands
       to the unprivileged build user. The old PID-only name was predictable,
       so a hostile process running as that user could pre-plant a symlink
       and root's fopen() would follow it, truncating or rewriting an
       arbitrary file. O_CREAT|O_EXCL makes the create atomic (open(2) refuses
       to follow a symlink when both are set), O_NOFOLLOW is the explicit
       belt-and-braces, and the nonce name makes pre-planting impractical.
       On EEXIST we pick a fresh name; anything else is a real error and we
       give up rather than guessing that the directory is still writable. */
    char script[600];
    int fd = -1;
    for (int attempt = 0; attempt < 16 && fd < 0; attempt++) {
        xsnprintf(script, sizeof(script), "%s/.archtoo-step-%ld-%08lx.sh",
                  EMERGE_DIR, (long)getpid(), step_nonce() & 0xffffffffUL);
        fd = open(script, O_WRONLY | O_CREAT | O_EXCL | O_NOFOLLOW, 0700);
        if (fd < 0 && errno != EEXIST)
            break; /* EACCES, ENOSPC, ... -- retrying will not help */
    }

    if (fd < 0) {
        fprintf(stderr, COLOR_RED "[-] Cannot create step script in %s: %s\n"
                COLOR_RESET, EMERGE_DIR, strerror(errno));
        return -1;
    }

    FILE *f = fdopen(fd, "w");
    if (!f) {
        fprintf(stderr, COLOR_RED "[-] fdopen failed for %s\n" COLOR_RESET, script);
        close(fd);
        unlink(script);
        return -1;
    }
    fprintf(f, "#!/bin/sh\n%s%s\n", extra_env ? extra_env : "", cmd);
    if (fclose(f) != 0) {
        fprintf(stderr, COLOR_RED "[-] Cannot finish writing %s\n" COLOR_RESET, script);
        unlink(script);
        return -1;
    }
    chmod(script, 0755);

    fix_owner(script);

    /* sudo keeps the current working directory, which makepkg needs. */
    char cmd_buf[1024];
    xsnprintf(cmd_buf, sizeof(cmd_buf), "sudo -u '%s' -- /bin/sh '%s'", user, script);

    int rc = run_cmd(cmd_buf);
    unlink(script);
    return rc;
}

int init_system(void) {
    char cmd[1024];

    if (!dir_exists(BUILD_DIR) || !dir_exists(BACKUP_DIR)) {
        xsnprintf(cmd, sizeof(cmd), "%smkdir -p '%s' '%s'",
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
            xsnprintf(cmd, sizeof(cmd), "%schown -R '%s' '%s'",
                      priv_prefix(), user, EMERGE_DIR);
            run_cmd_quiet(cmd);
        }
    }

    /* Same symlink discipline as run_as_user(): the world file lives in the
       user-owned EMERGE_DIR, and a pre-planted symlink would make this
       privileged create/append land elsewhere. */
    if (!file_exists(WORLD_FILE)) {
        FILE *f = fopen_nofollow(WORLD_FILE, "a");
        if (!f) {
            fprintf(stderr, COLOR_RED "[-] Cannot write world file %s\n" COLOR_RESET, WORLD_FILE);
            return 0;
        }
        fclose(f);
    }

    if (geteuid() == 0) {
        const char *user = build_user();
        if (user) {
            xsnprintf(cmd, sizeof(cmd), "chown '%s' '%s'", user, WORLD_FILE);
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
    xsnprintf(makeflags, sizeof(makeflags), "-j%ld", get_jobs());

    /* Kernel PKGBUILDs read KCFLAGS/KCPPFLAGS from the environment, so these
       still matter. CFLAGS/CXXFLAGS/MAKEFLAGS do NOT survive makepkg -- it
       sources /etc/makepkg.conf and overwrites them. Those go through
       write_makepkg_conf() and makepkg --config instead. */
    setenv("KCFLAGS", DEFAULT_KCFLAGS, 1);
    setenv("KCPPFLAGS", DEFAULT_KCFLAGS, 1);
    setenv("MAKEFLAGS", makeflags, 1);
}

int write_makepkg_conf(char *path_out, size_t n) {
    xsnprintf(path_out, n, "%s/makepkg.archtoo.conf", EMERGE_DIR);

    /* Root writes into the user-owned EMERGE_DIR: never follow a pre-planted
       symlink (see run_as_user()). */
    FILE *f = fopen_nofollow(path_out, "w");
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
