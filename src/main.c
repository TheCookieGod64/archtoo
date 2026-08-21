#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "../headers/version.h"
#include "../headers/colors.h"
#include "../headers/utils.h"
#include "../headers/world.h"
#include "../headers/unmerge.h"
#include "../headers/build.h"

static void print_usage(void) {
    printf(COLOR_CYAN "%s v%s\n" COLOR_RESET, ARCHTOO_NAME, ARCHTOO_VERSION);
    printf("Usage:\n");
    printf("  emerge <package>...    Build and compile one or more packages\n");
    printf("  emerge -C <package>... Unmerge and remove packages\n");
    printf("  emerge -U              World update (@world)\n");
    printf("  emerge -v              Show version information\n");
    printf("\nOptions:\n");
    printf("  --noconfirm            Never prompt; use safe defaults\n");
}

int main(int argc, char *argv[]) {
    int argi = 1;

    /* Version and usage need no privileges and no /usr/local/emerge, so they
       are handled before init_system() shells out to sudo. */
    if (argc < 2) {
        print_usage();
        return 1;
    }

    if (strcmp(argv[1], "-v") == 0 || strcmp(argv[1], "--version") == 0) {
        printf("%s v%s (Compiled C Edition)\n", ARCHTOO_NAME, ARCHTOO_VERSION);
        return 0;
    }

    if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
        print_usage();
        return 0;
    }

    if (geteuid() == 0) {
        fprintf(stderr, COLOR_RED
                "[-] Do not run emerge as root: makepkg refuses to build as root.\n"
                "    Run it as your normal user; it calls sudo where needed.\n" COLOR_RESET);
        return 1;
    }

    /* Collect global flags from anywhere in the argument list. */
    int filtered_argc = 0;
    char *filtered[256];
    for (int i = 1; i < argc && filtered_argc < 255; i++) {
        if (strcmp(argv[i], "--noconfirm") == 0) {
            set_noconfirm(1);
            continue;
        }
        filtered[filtered_argc++] = argv[i];
    }
    filtered[filtered_argc] = NULL;

    if (filtered_argc == 0) {
        print_usage();
        return 1;
    }

    argi = 0;

    if (strcmp(filtered[argi], "-U") == 0 || strcmp(filtered[argi], "--update") == 0) {
        if (!init_system())
            return 1;
        return cmd_world_update() ? 0 : 1;
    }

    if (strcmp(filtered[argi], "-C") == 0 || strcmp(filtered[argi], "--unmerge") == 0) {
        if (filtered_argc < 2) {
            fprintf(stderr, COLOR_RED "[-] Error: specify a package name to unmerge.\n" COLOR_RESET);
            return 1;
        }
        if (!init_system())
            return 1;

        int failed = 0;
        for (int i = 1; i < filtered_argc; i++)
            if (!cmd_unmerge(filtered[i]))
                failed++;

        return failed ? 1 : 0;
    }

    if (filtered[argi][0] == '-') {
        fprintf(stderr, COLOR_RED "[-] Unknown option: %s\n" COLOR_RESET, filtered[argi]);
        print_usage();
        return 1;
    }

    /* Validate every name up front so a typo in the third package does not
       surface only after the first two have been compiled. */
    for (int i = 0; i < filtered_argc; i++) {
        if (!valid_pkgname(filtered[i])) {
            fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET, filtered[i]);
            return 1;
        }
    }

    if (!init_system())
        return 1;

    int failed = 0;
    for (int i = 0; i < filtered_argc; i++) {
        if (filtered_argc > 1)
            printf(COLOR_PURPLE "\n>>> [%d/%d] %s\n" COLOR_RESET,
                   i + 1, filtered_argc, filtered[i]);
        if (!cmd_build(filtered[i]))
            failed++;
    }

    if (failed) {
        fprintf(stderr, COLOR_RED "\n[-] %d package(s) failed.\n" COLOR_RESET, failed);
        return 1;
    }

    return 0;
}
