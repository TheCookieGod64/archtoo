/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
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
    printf("  emerge -U              World update: pacman -Syu, then rebuild @world\n");
    printf("  emerge -D <package>... Deselect: unlock and drop from @world,\n");
    printf("                         but keep the package installed\n");
    printf("  emerge -v              Show version information\n");
    printf("\nOptions:\n");
    printf("  --noconfirm            Never prompt; use safe defaults\n");
    printf("  -i, --interactive      Enable pacman confirmation prompts\n");
    printf("  --prompt-timeout SEC   Archtoo prompt timeout (0 waits forever)\n");
    printf("  -j, --jobs N           Parallel build jobs (default: all cores)\n");
    printf("  -r, --resume           Reuse the existing build tree and continue\n");
    printf("                         an interrupted compile\n");
    printf("  --no-keys              Do not import missing PGP signing keys\n");
    printf("  --no-inhibit           Allow the machine to suspend while building\n");
    printf("  --no-sync              Skip pacman -Syu during a world update\n");
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
        printf("Copyright (C) 2026 TheCookieGod64\n");
        printf("License GPLv3+: GNU GPL version 3 or later "
               "<https://gnu.org/licenses/gpl.html>\n");
        printf("This is free software: you are free to change and redistribute it.\n");
        printf("There is NO WARRANTY, to the extent permitted by law.\n");
        printf("See LICENSE.CKL for additional terms and the CKL-2.0 tradition.\n");
        return 0;
    }

    if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
        print_usage();
        return 0;
    }

    /* Gentoo-style: "sudo emerge <pkg>" is supported. makepkg still cannot
       run as root, so the compile is handed back to SUDO_USER. A bare root
       login has no unprivileged user to fall back to. */
    if (geteuid() == 0 && !getenv("SUDO_USER")) {
        fprintf(stderr, COLOR_RED
                "[-] Running as a root login is not supported.\n"
                "    makepkg refuses to build as root, and there is no SUDO_USER\n"
                "    to drop back to. Use 'sudo emerge <package>' from your\n"
                "    normal account instead.\n" COLOR_RESET);
        return 1;
    }

    /* Config supplies defaults; command-line flags below override it. */
    load_user_config();

    /* Collect global flags from anywhere in the argument list. */
    int filtered_argc = 0;
    char *filtered[256];
    for (int i = 1; i < argc && filtered_argc < 255; i++) {
        if (strcmp(argv[i], "--noconfirm") == 0) {
            set_noconfirm(1);
            continue;
        }

        if (strcmp(argv[i], "-i") == 0 || strcmp(argv[i], "--interactive") == 0) {
            set_interactive(1);
            continue;
        }

        if (strcmp(argv[i], "--prompt-timeout") == 0) {
            if (i + 1 >= argc) {
                fprintf(stderr, COLOR_RED "[-] --prompt-timeout needs seconds.\n" COLOR_RESET);
                return 1;
            }
            char *end = NULL;
            long seconds = strtol(argv[++i], &end, 10);
            if (!end || *end != '\0' || seconds < 0 || seconds > 86400) {
                fprintf(stderr, COLOR_RED "[-] Invalid timeout (expected 0-86400).\n" COLOR_RESET);
                return 1;
            }
            set_prompt_timeout(seconds);
            continue;
        }

        if (strcmp(argv[i], "-r") == 0 || strcmp(argv[i], "--resume") == 0) {
            set_resume(1);
            continue;
        }

        if (strcmp(argv[i], "--no-keys") == 0) {
            set_import_keys(0);
            continue;
        }

        if (strcmp(argv[i], "--no-inhibit") == 0) {
            set_inhibit(0);
            continue;
        }

        if (strcmp(argv[i], "--no-sync") == 0) {
            set_sync(0);
            continue;
        }

        if (strcmp(argv[i], "-j") == 0 || strcmp(argv[i], "--jobs") == 0) {
            if (i + 1 >= argc) {
                fprintf(stderr, COLOR_RED "[-] %s needs a number.\n" COLOR_RESET, argv[i]);
                return 1;
            }
            char *end = NULL;
            long n = strtol(argv[++i], &end, 10);
            if (!end || *end != '\0' || n < 1 || n > 1024) {
                fprintf(stderr, COLOR_RED
                        "[-] Invalid job count '%s' (expected 1-1024).\n" COLOR_RESET, argv[i]);
                return 1;
            }
            set_jobs(n);
            continue;
        }

        /* -j4 / --jobs=4 -- the joined forms must pass exactly the same
           validation as "-j 4": -j999999999 must not sail through to
           MAKEFLAGS and hand the shell a fork-bomb-shaped job count. */
        if (strncmp(argv[i], "-j", 2) == 0 && isdigit((unsigned char)argv[i][2])) {
            char *end = NULL;
            long n = strtol(argv[i] + 2, &end, 10);
            if (!end || *end != '\0' || n < 1 || n > 1024) {
                fprintf(stderr, COLOR_RED
                        "[-] Invalid job count '%s' (expected 1-1024).\n" COLOR_RESET, argv[i]);
                return 1;
            }
            set_jobs(n);
            continue;
        }
        if (strncmp(argv[i], "--jobs=", 7) == 0) {
            char *end = NULL;
            long n = strtol(argv[i] + 7, &end, 10);
            if (!end || *end != '\0' || n < 1 || n > 1024) {
                fprintf(stderr, COLOR_RED "[-] Invalid job count.\n" COLOR_RESET);
                return 1;
            }
            set_jobs(n);
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

    /* Authenticate once and re-exec as root. Build steps are still handed
       back to SUDO_USER, while pacman never needs another password prompt. */
    if (!acquire_sudo(argc, argv))
        return 1;

    if (strcmp(filtered[argi], "-U") == 0 || strcmp(filtered[argi], "--update") == 0) {
        if (!init_system())
            return 1;
        return cmd_world_update() ? 0 : 1;
    }

    if (strcmp(filtered[argi], "-D") == 0 || strcmp(filtered[argi], "--deselect") == 0) {
        if (filtered_argc < 2) {
            fprintf(stderr, COLOR_RED "[-] Error: specify a package to deselect.\n" COLOR_RESET);
            return 1;
        }
        if (!init_system())
            return 1;

        int failed = 0;
        for (int i = 1; i < filtered_argc; i++)
            if (!cmd_deselect(filtered[i]))
                failed++;

        return failed ? 1 : 0;
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
        if (!get_resume())
            fprintf(stderr, COLOR_YELLOW
                    "    Tip: 'emerge --resume %s' continues from the existing\n"
                    "    build tree instead of starting over.\n" COLOR_RESET,
                    filtered[0]);
        return 1;
    }

    return 0;
}
