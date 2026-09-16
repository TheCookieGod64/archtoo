/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <poll.h>
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
static int  g_aur_sync = 1;
static int  g_interactive = 0;
static int  g_emerge_confirm = 1;
static long g_prompt_timeout = 300;
static char g_target_arch[128] = "native";
static char g_opt_level[16] = "3";
static int  g_use_pipe = 1;

void set_noconfirm(int v) { g_noconfirm = v; }
int  get_noconfirm(void)  { return g_noconfirm; }
void set_emerge_confirm(int v) { g_emerge_confirm = v; }
int  get_emerge_confirm(void) { return g_emerge_confirm; }
void set_interactive(int v) { g_interactive = v; }
int  get_interactive(void)  { return g_interactive; }
int  use_noconfirm(void) { return g_noconfirm || !g_interactive; }
void set_prompt_timeout(long v) { g_prompt_timeout = v; }
long get_prompt_timeout(void) { return g_prompt_timeout; }

void set_resume(int v) { g_resume = v; }
int  get_resume(void)  { return g_resume; }

void set_import_keys(int v) { g_import_keys = v; }
int  get_import_keys(void)  { return g_import_keys; }

void set_inhibit(int v) { g_inhibit = v; }
int  get_inhibit(void)  { return g_inhibit; }

void set_sync(int v) { g_sync = v; }
int  get_sync(void)  { return g_sync; }

void set_aur_sync(int v) { g_aur_sync = v; }
int  get_aur_sync(void)  { return g_aur_sync; }

void set_jobs(long n) { g_jobs = n; }

/* An explicit --jobs wins; otherwise use every core. On a memory-tight
   machine -j<cores> is often the wrong default: each parallel rustc or
   C++ TU can hold gigabytes, and the LTO link at the end is one huge
   single process. */
long get_jobs(void) {
    return (g_jobs > 0) ? g_jobs : get_cpu_cores();
}

int valid_target_arch(const char *s) {
    if (!s || !*s)
        return 0;
    size_t len = strlen(s);
    if (len == 0 || len > 64)
        return 0;
    /* Allow help/list as pseudo-targets for --target help */
    if (strcmp(s, "help") == 0 || strcmp(s, "list") == 0)
        return 1;
    if (!isalnum((unsigned char)s[0]))
        return 0;
    for (const char *p = s; *p; p++) {
        unsigned char c = (unsigned char)*p;
        if (!(isalnum(c) || c == '-' || c == '_' || c == '.'))
            return 0;
    }
    return 1;
}

void set_target_arch(const char *arch) {
    if (!arch || !valid_target_arch(arch))
        return;
    /* help/list are not real archs, keep previous */
    if (strcmp(arch, "help") == 0 || strcmp(arch, "list") == 0)
        return;
    xsnprintf(g_target_arch, sizeof(g_target_arch), "%s", arch);
}

const char *get_target_arch(void) {
    return g_target_arch;
}

void print_known_targets(void) {
    printf(COLOR_CYAN "Known --target values (common x86-64 -march):\n" COLOR_RESET);
    printf("  native (default, detects host CPU)\n");
    printf("  x86-64, x86-64-v2, x86-64-v3, x86-64-v4, generic\n");
    printf("\n" COLOR_CYAN "Intel:\n" COLOR_RESET);
    printf("  bonnell, atom, silvermont, goldmont, goldmont-plus, tremont\n");
    printf("  core2, nehalem, westmere, sandybridge, ivybridge\n");
    printf("  haswell, broadwell, skylake, skylake-avx512, cannonlake\n");
    printf("  icelake-client, icelake-server, cascadelake, tigerlake\n");
    printf("  sapphirerapids, alderlake, raptorlake, meteorlake, arrowlake\n");
    printf("  lunarlake, emeraldrapids, graniterapids\n");
    printf("\n" COLOR_CYAN "AMD:\n" COLOR_RESET);
    printf("  k8, athlon64, amdfam10, bdver1, bdver2, bdver3, bdver4\n");
    printf("  znver1, znver2, znver3, znver4, znver5\n");
    printf("  btver1, btver2\n");
    printf("\nExamples:\n");
    printf("  emerge --target=skylake htop\n");
    printf("  emerge --target=znver3 firefox\n");
    printf("  emerge --target=x86-64-v3 --jobs 4 linux-zen\n");
    printf("  emerge --target=native -U   (explicit default)\n");
}

/* --- Optimization level handling --- */
int valid_opt_level(const char *s) {
    if (!s || !*s)
        return 0;
    /* Allow help/list */
    if (strcmp(s, "help") == 0 || strcmp(s, "list") == 0)
        return 1;
    /* Normalize: strip leading -O or O */
    const char *p = s;
    if (*p == '-') p++;
    if (*p == 'O' || *p == 'o') p++;
    if (!*p) return 0;
    /* Now p should be 0,1,2,3,s,fast,g,z */
    if (strcmp(p, "0") == 0) return 1;
    if (strcmp(p, "1") == 0) return 1;
    if (strcmp(p, "2") == 0) return 1;
    if (strcmp(p, "3") == 0) return 1;
    if (strcmp(p, "s") == 0) return 1;
    if (strcmp(p, "fast") == 0) return 1;
    if (strcmp(p, "g") == 0) return 1;
    if (strcmp(p, "z") == 0) return 1;
    return 0;
}

void set_opt_level(const char *level) {
    if (!level || !valid_opt_level(level))
        return;
    if (strcmp(level, "help") == 0 || strcmp(level, "list") == 0)
        return;
    const char *p = level;
    if (*p == '-') p++;
    if (*p == 'O' || *p == 'o') p++;
    /* p now is normalized */
    if (strcmp(p, "0") == 0 || strcmp(p, "1") == 0 || strcmp(p, "2") == 0 ||
        strcmp(p, "3") == 0 || strcmp(p, "s") == 0 || strcmp(p, "g") == 0 ||
        strcmp(p, "z") == 0 || strcmp(p, "fast") == 0) {
        xsnprintf(g_opt_level, sizeof(g_opt_level), "%s", p);
    }
}

const char *get_opt_level(void) {
    return g_opt_level;
}

void print_known_opt_levels(void) {
    printf(COLOR_CYAN "Known --opt-level values:\n" COLOR_RESET);
    printf("  0      -O0 no optimization (debug)\n");
    printf("  1      -O1 basic\n");
    printf("  2      -O2 balanced (Arch default, good for low RAM)\n");
    printf("  3      -O3 aggressive (archtoo default)\n");
    printf("  s      -Os optimize for size\n");
    printf("  z      -Oz even more size (clang)\n");
    printf("  fast   -Ofast break standards, max speed\n");
    printf("  g      -Og debug friendly\n");
    printf("\nExamples:\n");
    printf("  emerge --opt-level=2 htop\n");
    printf("  emerge -O2 htop               (short)\n");
    printf("  emerge --target=skylake -O2 htop\n");
    printf("  emerge --opt-level=fast --no-pipe firefox\n");
}

void set_use_pipe(int v) { g_use_pipe = v ? 1 : 0; }
int get_use_pipe(void) { return g_use_pipe; }

int run_cmd(const char *cmd) {
    pid_t pid = fork();
    if (pid < 0)
        return -1;
    if (pid == 0) {
        struct sigaction sa;
        memset(&sa, 0, sizeof(sa));
        sa.sa_handler = SIG_DFL;
        sigemptyset(&sa.sa_mask);
        sigaction(SIGINT, &sa, NULL);
        sigaction(SIGTERM, &sa, NULL);
        sigaction(SIGHUP, &sa, NULL);
        execl("/bin/sh", "sh", "-c", cmd, (char *)NULL);
        _exit(127);
    }
    int st;
    while (waitpid(pid, &st, 0) < 0) {
        if (errno == EINTR)
            continue;
        return -1;
    }
    if (WIFSIGNALED(st))
        return 128 + WTERMSIG(st);
    return WIFEXITED(st) ? WEXITSTATUS(st) : -1;
}

int run_cmd_quiet(const char *cmd) {
    char buf[4608];
    xsnprintf(buf, sizeof(buf), "%s >/dev/null 2>&1", cmd);
    return run_cmd(buf);
}

int run_cmd_capture(const char *cmd, char **out) {
    int pipefd[2];
    pid_t pid;
    size_t cap = 4096, len = 0;
    char *buf;
    int st;
    if (out)
        *out = NULL;
    if (!cmd || !out)
        return -1;
    if (pipe(pipefd) != 0)
        return -1;
    pid = fork();
    if (pid < 0) {
        close(pipefd[0]);
        close(pipefd[1]);
        return -1;
    }
    if (pid == 0) {
        struct sigaction sa;
        int dn;
        memset(&sa, 0, sizeof(sa));
        sa.sa_handler = SIG_DFL;
        sigemptyset(&sa.sa_mask);
        sigaction(SIGINT, &sa, NULL);
        sigaction(SIGTERM, &sa, NULL);
        sigaction(SIGHUP, &sa, NULL);
        close(pipefd[0]);
        if (dup2(pipefd[1], STDOUT_FILENO) < 0)
            _exit(127);
        close(pipefd[1]);
        dn = open("/dev/null", O_WRONLY);
        if (dn >= 0) {
            dup2(dn, STDERR_FILENO);
            close(dn);
        }
        execl("/bin/sh", "sh", "-c", cmd, (char *)NULL);
        _exit(127);
    }
    close(pipefd[1]);
    buf = malloc(cap);
    if (!buf) {
        close(pipefd[0]);
        waitpid(pid, NULL, 0);
        return -1;
    }
    for (;;) {
        ssize_t n;
        if (len + 1024 >= cap) {
            size_t ncap = cap * 2;
            char *nbuf;
            if (ncap > 16u * 1024u * 1024u) {
                free(buf);
                close(pipefd[0]);
                waitpid(pid, NULL, 0);
                return -1;
            }
            nbuf = realloc(buf, ncap);
            if (!nbuf) {
                free(buf);
                close(pipefd[0]);
                waitpid(pid, NULL, 0);
                return -1;
            }
            buf = nbuf;
            cap = ncap;
        }
        n = read(pipefd[0], buf + len, cap - len - 1);
        if (n < 0) {
            if (errno == EINTR)
                continue;
            free(buf);
            close(pipefd[0]);
            waitpid(pid, NULL, 0);
            return -1;
        }
        if (n == 0)
            break;
        len += (size_t)n;
    }
    close(pipefd[0]);
    buf[len] = '\0';
    while (waitpid(pid, &st, 0) < 0) {
        if (errno == EINTR)
            continue;
        free(buf);
        return -1;
    }
    *out = buf;
    if (WIFSIGNALED(st))
        return 128 + WTERMSIG(st);
    return WIFEXITED(st) ? WEXITSTATUS(st) : -1;
}

int shell_quote(const char *in, char *out, size_t n) {
    size_t j = 0;
    if (!in || !out || n < 3)
        return 0;
    out[j++] = '\'';
    for (const char *p = in; *p; p++) {
        if (*p == '\'') {
            if (j + 4 >= n)
                return 0;
            out[j++] = '\'';
            out[j++] = '\\';
            out[j++] = '\'';
            out[j++] = '\'';
        } else {
            if (j + 1 >= n)
                return 0;
            out[j++] = *p;
        }
    }
    if (j + 1 >= n)
        return 0;
    out[j++] = '\'';
    out[j] = '\0';
    return 1;
}

int valid_search_query(const char *s) {
    if (!s || !*s || strlen(s) > 128)
        return 0;
    for (const char *p = s; *p; p++) {
        unsigned char c = (unsigned char)*p;
        if (!(isalnum(c) || strchr(" @._+-/", (int)c)))
            return 0;
    }
    return 1;
}

void dep_basename(const char *dep, char *out, size_t n) {
    size_t i = 0;
    if (!out || n == 0)
        return;
    if (!dep) {
        out[0] = '\0';
        return;
    }
    while (*dep == ' ' || *dep == '\t')
        dep++;
    for (const char *p = dep; *p && i + 1 < n; p++) {
        if (*p == '>' || *p == '<' || *p == '=' || *p == ':' ||
            *p == ' ' || *p == '\t')
            break;
        out[i++] = *p;
    }
    out[i] = '\0';
}

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

const char *build_user(void) {
    const char *u = getenv("SUDO_USER");
    if (u && *u)
        return u;
    struct passwd *pw = getpwuid(getuid());
    return (pw && pw->pw_name) ? pw->pw_name : NULL;
}

void load_user_config(void) {
    archtoo_config_t config;
    char error[512];
    if (!config_load(&config, error, sizeof(error))) {
        fprintf(stderr, COLOR_RED "[-] Configuration error: %s\n" COLOR_RESET,
                error);
        return;
    }
    config_apply(&config);
}

const char *priv_prefix(void) {
    return (geteuid() == 0) ? "" : "sudo ";
}

int acquire_sudo(int argc, char *argv[]) {
    if (geteuid() == 0)
        return 1;
    if (!have_cmd("sudo")) {
        fprintf(stderr, COLOR_RED "[-] sudo is required.\n" COLOR_RESET);
        return 0;
    }
    if (run_cmd("sudo -k") != 0) {
        fprintf(stderr, COLOR_RED "[-] Could not invalidate sudo credentials.\n"
                COLOR_RESET);
        return 0;
    }
    char **sudo_argv = calloc((size_t)argc + 3, sizeof(*sudo_argv));
    if (!sudo_argv) {
        fprintf(stderr, COLOR_RED "[-] Out of memory.\n" COLOR_RESET);
        return 0;
    }
    char sudo_cmd[] = "sudo";
    char separator[] = "--";
    sudo_argv[0] = sudo_cmd;
    sudo_argv[1] = separator;
    for (int i = 0; i < argc; i++)
        sudo_argv[i + 2] = argv[i];
    sudo_argv[argc + 2] = NULL;
    execvp("sudo", sudo_argv);
    fprintf(stderr, COLOR_RED "[-] Could not execute sudo: %s\n" COLOR_RESET,
            strerror(errno));
    free(sudo_argv);
    return 0;
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
    struct timespec ts;
    clock_gettime(CLOCK_REALTIME, &ts);
    return (unsigned long)ts.tv_nsec ^ ((unsigned long)getpid() << 16) ^
           (unsigned long)clock();
}

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
    char script[600];
    int fd = -1;
    for (int attempt = 0; attempt < 16 && fd < 0; attempt++) {
        xsnprintf(script, sizeof(script), "%s/.archtoo-step-%ld-%08lx.sh",
                  EMERGE_DIR, (long)getpid(), step_nonce() & 0xffffffffUL);
        fd = open(script, O_WRONLY | O_CREAT | O_EXCL | O_NOFOLLOW, 0700);
        if (fd < 0 && errno != EEXIST)
            break;
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
    fprintf(f, "#!/bin/sh\ntrap 'exit 130' INT\ntrap 'exit 143' TERM\n"
               "trap 'exit 129' HUP\n%s%s\n",
            extra_env ? extra_env : "", cmd);
    if (fclose(f) != 0) {
        fprintf(stderr, COLOR_RED "[-] Cannot finish writing %s\n" COLOR_RESET, script);
        unlink(script);
        return -1;
    }
    chmod(script, 0755);
    fix_owner(script);
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
    if (geteuid() == 0 || access(EMERGE_DIR, W_OK) != 0) {
        const char *user = build_user();
        if (user && valid_pkgname(user) == 0) {
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
    char kflags[256];
    char pipe_part[16];
    xsnprintf(makeflags, sizeof(makeflags), "-j%ld", get_jobs());
    xsnprintf(pipe_part, sizeof(pipe_part), "%s", get_use_pipe() ? " -pipe" : "");
    xsnprintf(kflags, sizeof(kflags), "-march=%s -O%s%s", get_target_arch(), get_opt_level(), pipe_part);
    setenv("KCFLAGS", kflags, 1);
    setenv("KCPPFLAGS", kflags, 1);
    setenv("MAKEFLAGS", makeflags, 1);
}

int write_makepkg_conf(char *path_out, size_t n) {
    char cflags[256];
    char cxxflags[256];
    char rustflags[256];
    char pipe_part[16];
    char opt[16];
    xsnprintf(pipe_part, sizeof(pipe_part), "%s", get_use_pipe() ? " -pipe" : "");
    xsnprintf(opt, sizeof(opt), "%s", get_opt_level());
    xsnprintf(cflags, sizeof(cflags), "-march=%s -O%s%s", get_target_arch(), opt, pipe_part);
    xsnprintf(cxxflags, sizeof(cxxflags), "-march=%s -O%s%s", get_target_arch(), opt, pipe_part);
    /* Map C opt level to Rust opt level: 0->0,1->1,2->2,3->3,s/z->s, fast->3, g->1 */
    const char *rust_opt = "3";
    if (strcmp(opt, "0") == 0) rust_opt = "0";
    else if (strcmp(opt, "1") == 0) rust_opt = "1";
    else if (strcmp(opt, "2") == 0) rust_opt = "2";
    else if (strcmp(opt, "s") == 0 || strcmp(opt, "z") == 0) rust_opt = "s";
    else if (strcmp(opt, "g") == 0) rust_opt = "1";
    else rust_opt = "3";
    xsnprintf(rustflags, sizeof(rustflags), "-C opt-level=%s -C target-cpu=%s", rust_opt, get_target_arch());
    xsnprintf(path_out, n, "%s/makepkg.archtoo.conf", EMERGE_DIR);
    FILE *f = fopen_nofollow(path_out, "w");
    if (!f) {
        fprintf(stderr, COLOR_RED "[-] Cannot write %s\n" COLOR_RESET, path_out);
        return 0;
    }
    fprintf(f,
            "# Generated by archtoo -- do not edit, it is rewritten every build.\n"
            "# target=%s opt=%s pipe=%d\n"
            "source /etc/makepkg.conf\n"
            "CFLAGS=\"%s\"\n"
            "CXXFLAGS=\"%s\"\n"
            "LDFLAGS=\"${LDFLAGS}\"\n"
            "RUSTFLAGS=\"%s\"\n"
            "MAKEFLAGS=\"-j%ld\"\n",
            get_target_arch(), opt, get_use_pipe(), cflags, cxxflags, rustflags, get_jobs());
    fclose(f);
    fix_owner(path_out);
    return 1;
}

int ask_yes_no(const char *question, int default_yes) {
    char reply[64];
    if (g_noconfirm || !g_emerge_confirm || !isatty(STDIN_FILENO)) {
        printf("%s [%s]: %s (auto)\n", question, default_yes ? "Y/n" : "y/N",
               default_yes ? "yes" : "no");
        return default_yes;
    }
    printf("%s [%s]: ", question, default_yes ? "Y/n" : "y/N");
    fflush(stdout);
    if (g_prompt_timeout > 0) {
        struct pollfd pfd = { .fd = STDIN_FILENO, .events = POLLIN };
        int timeout_ms = (g_prompt_timeout > 2147483) ? 2147483000
                                                       : (int)g_prompt_timeout * 1000;
        int ready = poll(&pfd, 1, timeout_ms);
        if (ready == 0) {
            printf("%s (default after %lds)\n", default_yes ? "yes" : "no",
                   g_prompt_timeout);
            return default_yes;
        }
        if (ready < 0 && errno != EINTR)
            return default_yes;
    }
    if (!fgets(reply, sizeof(reply), stdin))
        return default_yes;
    if (!strchr(reply, '\n')) {
        int c;
        while ((c = getchar()) != '\n' && c != EOF)
            ;
    }
    if (reply[0] == '\n' || reply[0] == '\r' || reply[0] == '\0')
        return default_yes;
    return (reply[0] == 'y' || reply[0] == 'Y');
}
