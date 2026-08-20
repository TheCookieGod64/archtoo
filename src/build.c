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
        printf(COLOR_RED "[-] Cannot change directory to build path.\n" COLOR_RESET);
        return 0;
    }

    if (dir_exists(path)) {
        printf("Existing build directory found. Pulling updates via Git...\n");
        snprintf(cmd, sizeof(cmd), "cd %s && git pull", path);
        run_cmd(cmd);
        return 1;
    }

    printf("Searching in official Arch repositories...\n");
    snprintf(cmd, sizeof(cmd), "pkgctl repo clone --protocol=https %s 2>/dev/null", pkg);

    if (run_cmd(cmd) == 0)
        return 1;

    printf(COLOR_YELLOW "[!] Not found in official repos. Trying AUR...\n" COLOR_RESET);
    snprintf(cmd, sizeof(cmd), "git clone https://aur.archlinux.org/%s.git 2>/dev/null", pkg);

    if (run_cmd(cmd) == 0)
        return 1;

    printf(COLOR_RED "[-] Package '%s' not found in Arch Repos or AUR!\n" COLOR_RESET, pkg);
    return 0;
}

int compile_package(const char *pkg) {
    char path[512];
    snprintf(path, sizeof(path), "%s/%s", BUILD_DIR, pkg);

    if (chdir(path) != 0)
        return 0;

    printf(COLOR_BLUE ">>> Edit PKGBUILD for custom flags?\n" COLOR_RESET);
    if (ask_yes_no("Open in editor")) {
        char cmd[512];
        snprintf(cmd, sizeof(cmd), "%s PKGBUILD", get_editor());
        run_cmd(cmd);
    }

    set_build_env();

    printf(COLOR_BLUE ">>> Compiling with makepkg (-march=native -O3 on %ld cores)...\n" COLOR_RESET,
           get_cpu_cores());

    if (run_cmd("makepkg -si") != 0) {
        printf(COLOR_RED "[-] Compilation failed.\n" COLOR_RESET);
        return 0;
    }

    return 1;
}

void lock_pacman_pkg(const char *pkg) {
    char cmd[1024];

    snprintf(cmd, sizeof(cmd),
             "grep -q \"IgnorePkg.*\\<%s\\>\" %s", pkg, PACMAN_CONF);

    if (run_cmd(cmd) == 0) {
        printf(COLOR_GREEN "[+] %s is already locked in IgnorePkg\n" COLOR_RESET, pkg);
        return;
    }

    snprintf(cmd, sizeof(cmd),
             "if grep -q '^IgnorePkg' %s; then "
             "sudo sed -i '/^IgnorePkg/ s/$/ %s/' %s; "
             "elif grep -q '^#IgnorePkg' %s; then "
             "sudo sed -i 's/^#IgnorePkg =/IgnorePkg = %s/' %s; "
             "else "
             "sudo sed -i '/^\\[options\\]/a IgnorePkg = %s' %s; "
             "fi",
             PACMAN_CONF, pkg, PACMAN_CONF,
             PACMAN_CONF, pkg, PACMAN_CONF,
             pkg, PACMAN_CONF);

    run_cmd(cmd);
    printf(COLOR_GREEN "[+] %s locked in pacman.conf\n" COLOR_RESET, pkg);
}

void cleanup_build_dir(const char *pkg) {
    printf(COLOR_BLUE ">>> Clean up build directory?\n" COLOR_RESET);
    if (!ask_yes_no("Remove directory")) {
        printf(COLOR_YELLOW "[-] Build directory preserved in %s/%s\n" COLOR_RESET, BUILD_DIR, pkg);
        return;
    }

    char cmd[512];
    snprintf(cmd, sizeof(cmd), "rm -rf %s/%s", BUILD_DIR, pkg);
    run_cmd(cmd);
    printf(COLOR_GREEN "[+] Build directory cleaned up!\n" COLOR_RESET);
}

void cmd_build(const char *pkg) {
    printf(COLOR_BLUE ">>> [1/6] Fetching sources for %s...\n" COLOR_RESET, pkg);
    if (!fetch_sources(pkg))
        return;

    printf(COLOR_BLUE ">>> [2-3/6] Compiling package...\n" COLOR_RESET);
    if (!compile_package(pkg))
        return;

    if (is_kernel(pkg)) {
        printf(COLOR_BLUE ">>> [4/6] Running kernel hooks...\n" COLOR_RESET);
        run_kernel_hooks(pkg);

        char headers[256];
        snprintf(headers, sizeof(headers), "%s-headers", pkg);
        lock_pacman_pkg(headers);
    }

    printf(COLOR_BLUE ">>> [5/6] Locking in pacman.conf...\n" COLOR_RESET);
    lock_pacman_pkg(pkg);
    add_to_world(pkg);

    printf(COLOR_BLUE ">>> [6/6] Cleaning up...\n" COLOR_RESET);
    cleanup_build_dir(pkg);

    printf(COLOR_GREEN "\n>>> DONE! %s is custom built and installed!\n" COLOR_RESET, pkg);

    if (is_kernel(pkg))
        printf(COLOR_YELLOW "[!] Reboot your system to boot into your new kernel!\n" COLOR_RESET);
}
