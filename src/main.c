#include <stdio.h>
#include <string.h>

#include "../headers/version.h"
#include "../headers/colors.h"
#include "../headers/utils.h"
#include "../headers/world.h"
#include "../headers/unmerge.h"
#include "../headers/build.h"

static void print_usage(void) {
    printf(COLOR_CYAN "%s v%s\n" COLOR_RESET, ARCHTOO_NAME, ARCHTOO_VERSION);
    printf("Usage:\n");
    printf("  emerge <package>       Build and compile a package\n");
    printf("  emerge -C <package>    Unmerge and remove a package\n");
    printf("  emerge -U              World update (@world)\n");
    printf("  emerge -v              Show version information\n");
}

int main(int argc, char *argv[]) {
    init_system();

    if (argc < 2) {
        print_usage();
        return 1;
    }

    if (strcmp(argv[1], "-v") == 0 || strcmp(argv[1], "--version") == 0) {
        printf("%s v%s (Compiled C Edition)\n", ARCHTOO_NAME, ARCHTOO_VERSION);
        return 0;
    }

    if (strcmp(argv[1], "-U") == 0 || strcmp(argv[1], "--update") == 0) {
        cmd_world_update();
        return 0;
    }

    if (strcmp(argv[1], "-C") == 0 || strcmp(argv[1], "--unmerge") == 0) {
        if (argc < 3) {
            printf(COLOR_RED "[-] Error: Specify a package name to unmerge!\n" COLOR_RESET);
            return 1;
        }
        cmd_unmerge(argv[2]);
        return 0;
    }

    if (argv[1][0] == '-') {
        printf(COLOR_RED "[-] Unknown option: %s\n" COLOR_RESET, argv[1]);
        print_usage();
        return 1;
    }

    cmd_build(argv[1]);
    return 0;
}
