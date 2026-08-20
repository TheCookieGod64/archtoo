#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

#include "../headers/utils.h"
#include "../headers/config.h"
#include "../headers/colors.h"

int run_cmd(const char *cmd) {
    return system(cmd);
}

int file_exists(const char *path) {
    struct stat st;
    return (stat(path, &st) == 0) && S_ISREG(st.st_mode);
}

int dir_exists(const char *path) {
    struct stat st;
    return (stat(path, &st) == 0) && S_ISDIR(st.st_mode);
}

void init_system(void) {
    if (!dir_exists(BUILD_DIR)) {
        run_cmd("sudo mkdir -p " BUILD_DIR);

        char chown_cmd[512];
        const char *user = getenv("USER");
        if (user) {
            snprintf(chown_cmd, sizeof(chown_cmd),
                     "sudo chown -R %s:%s %s", user, user, EMERGE_DIR);
            run_cmd(chown_cmd);
        }
    }

    if (!file_exists(WORLD_FILE)) {
        FILE *f = fopen(WORLD_FILE, "a");
        if (f) fclose(f);
    }
}

char *get_editor(void) {
    char *editor = getenv("EDITOR");
    return editor ? editor : "nano";
}

long get_cpu_cores(void) {
    long cores = sysconf(_SC_NPROCESSORS_ONLN);
    return (cores > 0) ? cores : 1;
}

void set_build_env(void) {
    char makeflags[64];
    snprintf(makeflags, sizeof(makeflags), "-j%ld", get_cpu_cores());

    setenv("CFLAGS", DEFAULT_CFLAGS, 1);
    setenv("CXXFLAGS", DEFAULT_CXXFLAGS, 1);
    setenv("KCFLAGS", DEFAULT_KCFLAGS, 1);
    setenv("KCPPFLAGS", DEFAULT_KCFLAGS, 1);
    setenv("MAKEFLAGS", makeflags, 1);
}

int ask_yes_no(const char *question) {
    char reply[8];
    printf("%s [Y/n]: ", question);
    fflush(stdout);

    if (!fgets(reply, sizeof(reply), stdin))
        return 1;

    return !(reply[0] == 'n' || reply[0] == 'N');
}
