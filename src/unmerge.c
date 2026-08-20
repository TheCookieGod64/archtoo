#include <stdio.h>
#include <stdlib.h>

#include "../headers/unmerge.h"
#include "../headers/world.h"
#include "../headers/utils.h"
#include "../headers/config.h"
#include "../headers/colors.h"

void unlock_pacman_pkg(const char *pkg) {
    char cmd[512];
    snprintf(cmd, sizeof(cmd),
             "sudo sed -i -E '/^IgnorePkg/ s/\\<%s\\>//g' %s",
             pkg, PACMAN_CONF);
    run_cmd(cmd);

    snprintf(cmd, sizeof(cmd),
             "sudo sed -i -E '/^IgnorePkg/ s/[[:space:]]+/ /g' %s",
             PACMAN_CONF);
    run_cmd(cmd);
}

void cmd_unmerge(const char *pkg) {
    printf(COLOR_BLUE ">>> [1/3] Unmerging %s via pacman...\n" COLOR_RESET, pkg);

    char cmd[512];
    snprintf(cmd, sizeof(cmd), "sudo pacman -Rns %s", pkg);

    if (run_cmd(cmd) != 0) {
        printf(COLOR_RED "[-] Unmerge failed.\n" COLOR_RESET);
        return;
    }

    printf(COLOR_BLUE ">>> [2/3] Unlocking %s in pacman.conf...\n" COLOR_RESET, pkg);
    unlock_pacman_pkg(pkg);

    printf(COLOR_BLUE ">>> [3/3] Cleaning up world file and build directories...\n" COLOR_RESET);
    remove_from_world(pkg);

    snprintf(cmd, sizeof(cmd), "rm -rf %s/%s", BUILD_DIR, pkg);
    run_cmd(cmd);

    printf(COLOR_GREEN "[+] %s successfully unmerged!\n" COLOR_RESET, pkg);
}
