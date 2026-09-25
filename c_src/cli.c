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
#include "../headers/gentoo_chroot.h"
#include "../headers/guide.h"
#include "../headers/operations.h"

static void print_usage(void) {
    printf(COLOR_CYAN "%s v%s\n" COLOR_RESET, ARCHTOO_NAME, ARCHTOO_VERSION);
    printf("Usage:\n");
    printf("  emerge <package>...    Build and install packages (-I alias)\n");
    printf("  emerge -S <query>       Search repositories and AUR\n");
    printf("  emerge -I <package>...  Install packages\n");
    printf("  emerge -Q <package>...  Query installed packages\n");
    printf("  emerge -A <package>...  Show repository/AUR information\n");
    printf("  emerge -G <package>...  Download AUR PKGBUILDs\n");
    printf("  emerge -B <directory>   Build a local PKGBUILD\n");
    printf("  emerge -C <package>... Unmerge and remove packages\n");
    printf("  emerge --orphans        List orphaned dependencies\n");
    printf("  emerge --clean          Clean package caches\n");
    printf("  emerge --stats          Show package statistics\n");
    printf("  emerge --news           Show recent Arch news\n");
    printf("  emerge --providers <n>  Packages that provide <n> (exact/Provides)\n");
    printf("  emerge --deps <n>       Dependency plan (repo or AUR, graph order)\n");
    printf("  emerge --devel          List installed VCS packages (-git/-hg/...)\n");
    printf("  emerge --review <dir>   Show PKGBUILD / .SRCINFO for review\n");
    printf("  emerge --complete       Print CLI flags and repo package names\n");
    printf("  emerge -U              World update: pacman -Syu, then rebuild @world\n");
    printf("  emerge -D <package>... Deselect: unlock and drop from @world,\n");
    printf("                         but keep the package installed\n");
    printf("  emerge -v              Show version information\n");
    printf("\nOptions:\n");
    printf("  --noconfirm            Never prompt; use safe defaults\n");
    printf("  -i, --interactive      Enable pacman confirmation prompts\n");
    printf("  --prompt-timeout SEC   Archtoo prompt timeout (0 waits forever)\n");
    printf("  -j, --jobs N           Parallel build jobs (default: all cores)\n");
    printf("  --target ARCH          Custom -march target (default: native)\n");
    printf("                         e.g. skylake, znver3, x86-64-v3, native\n");
    printf("  --target=ARCH          Same as --target ARCH\n");
    printf("  --march=ARCH           Alias for --target=ARCH\n");
    printf("  --opt-level LEVEL      Optimization: 0,1,2,3,s,fast,g,z (default: 3)\n");
    printf("                         e.g. -O2, 2, s, fast\n");
    printf("  --opt=LEVEL            Alias for --opt-level\n");
    printf("  -O0,-O1,-O2,-O3,-Os,-Ofast,-Og,-Oz  Short forms\n");
    printf("  --pipe                 Enable -pipe (default)\n");
    printf("  --no-pipe              Disable -pipe\n");
    printf("  --gentoo-chroot        Enable SUPER HARD Portage imitation via Gentoo chroot\n");
    printf("  --imitation            Alias for --gentoo-chroot\n");
    printf("  --no-gentoo-chroot     Disable chroot imitation\n");
    printf("  --chroot-path PATH     Custom chroot path (default: /usr/local/emerge/gentoo-chroot)\n");
    printf("  --binary               Try sudo pacman -S first, then yay-style AUR search for a prebuilt -bin (long flag only)\n");
    printf("                         Long flag only, no short form\n");
    printf("  --use-binary           Alias for --binary\n");
    printf("  --no-binary            Disable binary mode\n");
    printf("  -r, --resume           Reuse the existing build tree and continue\n");
    printf("                         an interrupted compile\n");
    printf("  --no-keys              Do not import missing PGP signing keys\n");
    printf("  --no-inhibit           Allow the machine to suspend while building\n");
    printf("  --no-sync              Skip pacman -Syu during a world update\n");
    printf("  --no-aur-sync          Reuse local AUR @world sources; do not refresh\n");
    printf("  --command-guide        Display the command guide now\n");
    printf("  --command-guide=MODE   Set guide mode: first-run, always, never\n");
}

int archtoo_cli_main(int argc, char *argv[]) {
    int argi = 1;

    if (geteuid() == 0 && !getenv("SUDO_USER")) {
        fprintf(stderr, COLOR_RED
                "[-] Running as a root login is not supported.\n"
                "    makepkg refuses to build as root, and there is no SUDO_USER\n"
                "    to drop back to. Use 'sudo emerge <package>' from your\n"
                "    normal account instead.\n" COLOR_RESET);
        return 1;
    }

    load_user_config();

    if (argc < 2) {
        if (strcmp(get_target_arch(), "native") != 0 || strcmp(get_opt_level(), "3") != 0 || !get_use_pipe() || get_gentoo_chroot()) {
            printf(COLOR_CYAN "Current config: target=%s opt=-O%s pipe=%s chroot=%s binary=%s path=%s\n" COLOR_RESET,
                   get_target_arch(), get_opt_level(), get_use_pipe() ? "yes" : "no",
                   get_gentoo_chroot() ? "on" : "off", get_use_binary() ? "on" : "off", get_gentoo_chroot_path());
        }
        print_usage();
        return 1;
    }

    if (strcmp(argv[1], "-v") == 0 || strcmp(argv[1], "--version") == 0) {
        printf("%s v%s (target=%s opt=-O%s pipe=%s chroot=%s binary=%s)\n", ARCHTOO_NAME, ARCHTOO_VERSION,
               get_target_arch(), get_opt_level(), get_use_pipe() ? "yes" : "no",
               get_gentoo_chroot() ? "on" : "off", get_use_binary() ? "on" : "off");
        printf("Copyright (C) 2026 TheCookieGod64\n");
        printf("License GPLv3+: GNU GPL version 3 or later "
               "<https://gnu.org/licenses/gpl.html>\n");
        return 0;
    }

    if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
        print_usage();
        if (strcmp(get_target_arch(), "native") != 0 || strcmp(get_opt_level(), "3") != 0) {
            printf(COLOR_CYAN "\nActive config: target=%s opt=-O%s pipe=%s\n" COLOR_RESET,
                   get_target_arch(), get_opt_level(), get_use_pipe() ? "yes" : "no");
        }
        return 0;
    }

    int filtered_argc = 0;
    char *filtered[256];
    for (int i = 1; i < argc && filtered_argc < 255; i++) {
        if (strcmp(argv[i], "--noconfirm") == 0) {
            set_noconfirm(1);
            continue;
        }
        if (strcmp(argv[i], "--command-guide") == 0) {
            guide_request_explicit();
            continue;
        }
        if (strncmp(argv[i], "--command-guide=", 16) == 0) {
            guide_policy_t policy;
            if (!guide_policy_parse(argv[i] + 16, &policy)) {
                fprintf(stderr, COLOR_RED
                        "[-] Invalid command-guide mode (use first-run, always, or never).\n"
                        COLOR_RESET);
                return 1;
            }
            guide_set_policy(policy);
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
        if (strcmp(argv[i], "--no-aur-sync") == 0) {
            set_aur_sync(0);
            continue;
        }
        if (strcmp(argv[i], "--pipe") == 0) {
            set_use_pipe(1);
            continue;
        }
        if (strcmp(argv[i], "--no-pipe") == 0) {
            set_use_pipe(0);
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
        if (strcmp(argv[i], "--target") == 0 || strcmp(argv[i], "--march") == 0 ||
            strcmp(argv[i], "--cpu") == 0) {
            if (i + 1 >= argc) {
                fprintf(stderr, COLOR_RED "[-] %s needs an architecture name.\n" COLOR_RESET, argv[i]);
                return 1;
            }
            const char *arch = argv[++i];
            if (strcmp(arch, "help") == 0 || strcmp(arch, "list") == 0) {
                print_known_targets();
                return 0;
            }
            if (!valid_target_arch(arch)) {
                fprintf(stderr, COLOR_RED "[-] Invalid target '%s'. Use --target help.\n" COLOR_RESET, arch);
                return 1;
            }
            set_target_arch(arch);
            continue;
        }
        if (strncmp(argv[i], "--target=", 9) == 0) {
            const char *arch = argv[i] + 9;
            if (!*arch) {
                fprintf(stderr, COLOR_RED "[-] --target= needs a value.\n" COLOR_RESET);
                return 1;
            }
            if (strcmp(arch, "help") == 0 || strcmp(arch, "list") == 0) {
                print_known_targets();
                return 0;
            }
            if (!valid_target_arch(arch)) {
                fprintf(stderr, COLOR_RED "[-] Invalid target '%s'. Use --target help.\n" COLOR_RESET, arch);
                return 1;
            }
            set_target_arch(arch);
            continue;
        }
        if (strncmp(argv[i], "--march=", 8) == 0) {
            const char *arch = argv[i] + 8;
            if (!*arch) {
                fprintf(stderr, COLOR_RED "[-] --march= needs a value.\n" COLOR_RESET);
                return 1;
            }
            if (strcmp(arch, "help") == 0 || strcmp(arch, "list") == 0) {
                print_known_targets();
                return 0;
            }
            if (!valid_target_arch(arch)) {
                fprintf(stderr, COLOR_RED "[-] Invalid march '%s'.\n" COLOR_RESET, arch);
                return 1;
            }
            set_target_arch(arch);
            continue;
        }
        if (strncmp(argv[i], "--cpu=", 6) == 0) {
            const char *arch = argv[i] + 6;
            if (!*arch) {
                fprintf(stderr, COLOR_RED "[-] --cpu= needs a value.\n" COLOR_RESET);
                return 1;
            }
            if (!valid_target_arch(arch)) {
                fprintf(stderr, COLOR_RED "[-] Invalid cpu '%s'.\n" COLOR_RESET, arch);
                return 1;
            }
            set_target_arch(arch);
            continue;
        }
        /* Optimization level flags */
        if (strcmp(argv[i], "--opt-level") == 0 || strcmp(argv[i], "--opt") == 0 ||
            strcmp(argv[i], "--optimization") == 0 || strcmp(argv[i], "-O") == 0) {
            if (i + 1 >= argc) {
                fprintf(stderr, COLOR_RED "[-] %s needs a level (0,1,2,3,s,fast,g,z).\n" COLOR_RESET, argv[i]);
                return 1;
            }
            const char *lvl = argv[++i];
            if (strcmp(lvl, "help") == 0 || strcmp(lvl, "list") == 0) {
                print_known_opt_levels();
                return 0;
            }
            if (!valid_opt_level(lvl)) {
                fprintf(stderr, COLOR_RED "[-] Invalid opt level '%s'. Use --opt-level help.\n" COLOR_RESET, lvl);
                return 1;
            }
            set_opt_level(lvl);
            continue;
        }
        if (strncmp(argv[i], "--opt-level=", 12) == 0) {
            const char *lvl = argv[i] + 12;
            if (!*lvl) {
                fprintf(stderr, COLOR_RED "[-] --opt-level= needs a value.\n" COLOR_RESET);
                return 1;
            }
            if (strcmp(lvl, "help") == 0 || strcmp(lvl, "list") == 0) {
                print_known_opt_levels();
                return 0;
            }
            if (!valid_opt_level(lvl)) {
                fprintf(stderr, COLOR_RED "[-] Invalid opt level '%s'.\n" COLOR_RESET, lvl);
                return 1;
            }
            set_opt_level(lvl);
            continue;
        }
        if (strncmp(argv[i], "--opt=", 6) == 0) {
            const char *lvl = argv[i] + 6;
            if (!valid_opt_level(lvl)) {
                fprintf(stderr, COLOR_RED "[-] Invalid opt '%s'.\n" COLOR_RESET, lvl);
                return 1;
            }
            set_opt_level(lvl);
            continue;
        }
        if (strncmp(argv[i], "--optimization=", 15) == 0) {
            const char *lvl = argv[i] + 15;
            if (!valid_opt_level(lvl)) {
                fprintf(stderr, COLOR_RED "[-] Invalid optimization '%s'.\n" COLOR_RESET, lvl);
                return 1;
            }
            set_opt_level(lvl);
            continue;
        }
        /* Short -O* forms: -O0, -O1, -O2, -O3, -Os, -Ofast, -Og, -Oz */
        if (strcmp(argv[i], "-O0") == 0 || strcmp(argv[i], "-O1") == 0 ||
            strcmp(argv[i], "-O2") == 0 || strcmp(argv[i], "-O3") == 0 ||
            strcmp(argv[i], "-Os") == 0 || strcmp(argv[i], "-Oz") == 0 ||
            strcmp(argv[i], "-Og") == 0) {
            set_opt_level(argv[i]);
            continue;
        }
        if (strcmp(argv[i], "-Ofast") == 0) {
            set_opt_level("fast");
            continue;
        }
        if (strncmp(argv[i], "-O", 2) == 0 && strlen(argv[i]) <= 7) {
            const char *lvl = argv[i] + 2;
            if (*lvl == '=') lvl++;
            if (valid_opt_level(lvl)) {
                set_opt_level(lvl);
                continue;
            }
        }
        if (strcmp(argv[i], "--gentoo-chroot") == 0 || strcmp(argv[i], "--imitation") == 0 ||
            strcmp(argv[i], "--portage-imitation") == 0 || strcmp(argv[i], "--gentoo-imitation") == 0) {
            set_gentoo_chroot(1);
            set_portage_imitation(1);
            continue;
        }
        if (strcmp(argv[i], "--no-gentoo-chroot") == 0 || strcmp(argv[i], "--no-imitation") == 0) {
            set_gentoo_chroot(0);
            set_portage_imitation(0);
            continue;
        }
        if (strncmp(argv[i], "--chroot-path=", 14) == 0) {
            const char *p = argv[i] + 14;
            if (!valid_gentoo_chroot_path(p)) {
                fprintf(stderr, COLOR_RED "[-] Invalid chroot path '%s'\n" COLOR_RESET, p);
                return 1;
            }
            set_gentoo_chroot_path(p);
            continue;
        }
        if (strcmp(argv[i], "--chroot-path") == 0) {
            if (i + 1 >= argc) {
                fprintf(stderr, COLOR_RED "[-] --chroot-path needs a path\n" COLOR_RESET);
                return 1;
            }
            const char *p = argv[++i];
            if (!valid_gentoo_chroot_path(p)) {
                fprintf(stderr, COLOR_RED "[-] Invalid chroot path '%s'\n" COLOR_RESET, p);
                return 1;
            }
            set_gentoo_chroot_path(p);
            continue;
        }
        if (strcmp(argv[i], "--binary") == 0 || strcmp(argv[i], "--use-binary") == 0 ||
            strcmp(argv[i], "--use-bin") == 0 || strcmp(argv[i], "--bin") == 0 ||
            strcmp(argv[i], "--prebuilt") == 0 || strcmp(argv[i], "--use-prebuilt") == 0 ||
            strcmp(argv[i], "--no-build") == 0 || strcmp(argv[i], "--no-compile") == 0) {
            set_use_binary(1);
            continue;
        }
        if (strcmp(argv[i], "--no-binary") == 0 || strcmp(argv[i], "--no-use-binary") == 0 ||
            strcmp(argv[i], "--no-bin") == 0 || strcmp(argv[i], "--no-prebuilt") == 0) {
            set_use_binary(0);
            continue;
        }

        filtered[filtered_argc++] = argv[i];
    }
    filtered[filtered_argc] = NULL;

    guide_maybe_show();

    if (filtered_argc == 1) {
        if (strcmp(filtered[0], "-v") == 0 || strcmp(filtered[0], "--version") == 0) {
            printf("%s v%s (target=%s opt=-O%s pipe=%s chroot=%s binary=%s)\n", ARCHTOO_NAME, ARCHTOO_VERSION,
                   get_target_arch(), get_opt_level(), get_use_pipe() ? "yes" : "no",
                   get_gentoo_chroot() ? "on" : "off", get_use_binary() ? "on" : "off");
            printf("Copyright (C) 2026 TheCookieGod64\n");
            return 0;
        }
        if (strcmp(filtered[0], "-h") == 0 || strcmp(filtered[0], "--help") == 0) {
            print_usage();
            return 0;
        }
    }

    if (filtered_argc == 0) {
        if (strcmp(get_target_arch(), "native") != 0 || strcmp(get_opt_level(), "3") != 0 || !get_use_pipe() || get_gentoo_chroot()) {
            printf(COLOR_CYAN "Current: target=%s opt=-O%s pipe=%s chroot=%s binary=%s jobs=%ld path=%s\n" COLOR_RESET,
                   get_target_arch(), get_opt_level(), get_use_pipe() ? "yes" : "no",
                   get_gentoo_chroot() ? "on" : "off", get_use_binary() ? "on" : "off", get_jobs(), get_gentoo_chroot_path());
        }
        return 0;
    }

    argi = 0;

    if (strcmp(filtered[argi], "-S") == 0) {
        if (filtered_argc != 2) {
            fprintf(stderr, COLOR_RED "[-] Search requires exactly one query.\n" COLOR_RESET);
            return 1;
        }
        return cmd_search_v2(filtered[1]) ? 0 : 1;
    } else if (strcmp(filtered[argi], "-Q") == 0 ||
               strcmp(filtered[argi], "-A") == 0) {
        if (filtered_argc < 2) {
            fprintf(stderr, COLOR_RED "[-] This operation requires a package.\n" COLOR_RESET);
            return 1;
        }
        int failed = 0;
        for (int i = 1; i < filtered_argc; i++) {
            int ok = filtered[argi][1] == 'Q' ? cmd_query_v2(filtered[i])
                                               : cmd_available_info_v2(filtered[i]);
            if (!ok) failed++;
        }
        return failed ? 1 : 0;
    } else if (strcmp(filtered[argi], "--orphans") == 0) {
        return cmd_orphans_v2() ? 0 : 1;
    } else if (strcmp(filtered[argi], "--stats") == 0) {
        return cmd_stats_v2() ? 0 : 1;
    } else if (strcmp(filtered[argi], "--news") == 0) {
        return cmd_news_v2() ? 0 : 1;
    } else if (strcmp(filtered[argi], "--complete") == 0) {
        return cmd_completion_v2() ? 0 : 1;
    } else if (strcmp(filtered[argi], "--devel") == 0) {
        return cmd_devel_v2() ? 0 : 1;
    } else if (strcmp(filtered[argi], "--providers") == 0 && filtered_argc == 2) {
        return cmd_provider_v2(filtered[1]) ? 0 : 1;
    } else if (strcmp(filtered[argi], "--deps") == 0 && filtered_argc == 2) {
        return cmd_dependency_plan_v2(filtered[1]) ? 0 : 1;
    } else if (strcmp(filtered[argi], "--review") == 0) {
        if (filtered_argc != 2) {
            fprintf(stderr, COLOR_RED "[-] --review requires a directory.\n" COLOR_RESET);
            return 1;
        }
        return cmd_review_v2(filtered[1]) ? 0 : 1;
    }

    if (!acquire_sudo(argc, argv))
        return 1;

    if (strcmp(filtered[argi], "-I") == 0) {
        if (filtered_argc < 2 || !init_system()) return 1;
        int failed = 0;
        if (get_use_binary()) {
            for (int i = 1; i < filtered_argc; i++)
                if (!cmd_build(filtered[i])) failed++;
        } else if (get_gentoo_chroot()) {
            for (int i = 1; i < filtered_argc; i++)
                if (!cmd_gentoo_imitation_build(filtered[i])) failed++;
        } else {
            for (int i = 1; i < filtered_argc; i++)
                if (!cmd_build(filtered[i])) failed++;
        }
        return failed ? 1 : 0;
    } else if (strcmp(filtered[argi], "-G") == 0) {
        if (filtered_argc < 2) return 1;
        int failed = 0;
        for (int i = 1; i < filtered_argc; i++)
            if (!cmd_get_pkgbuild_v2(filtered[i])) failed++;
        return failed ? 1 : 0;
    } else if (strcmp(filtered[argi], "-B") == 0) {
        return filtered_argc == 2 && cmd_local_build_v2(filtered[1]) ? 0 : 1;
    } else if (strcmp(filtered[argi], "--clean") == 0) {
        return cmd_clean_v2() ? 0 : 1;
    }

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

    for (int i = 0; i < filtered_argc; i++) {
        if (!valid_pkgname(filtered[i])) {
            fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET, filtered[i]);
            return 1;
        }
    }

    if (!init_system())
        return 1;

    /* Binary mode: against Gentoo principles but like yay - only long flag */
    if (get_use_binary()) {
        int failed = 0;
        for (int i = 0; i < filtered_argc; i++) {
            if (filtered_argc > 1)
                printf(COLOR_PURPLE "\n>>> [%d/%d] %s (binary mode)\n" COLOR_RESET,
                       i + 1, filtered_argc, filtered[i]);
            if (!cmd_build(filtered[i]))
                failed++;
        }
        if (failed) {
            fprintf(stderr, COLOR_RED "\n[-] %d package(s) failed in binary mode.\n" COLOR_RESET, failed);
            return 1;
        }
        return 0;
    }

    /* SUPER HARD IMITATION MODE: if enabled, use Gentoo chroot + real Portage */
    if (get_gentoo_chroot()) {
        int failed = 0;
        for (int i = 0; i < filtered_argc; i++) {
            if (filtered_argc > 1)
                printf(COLOR_PURPLE "\n>>> [%d/%d] %s (Gentoo chroot imitation)\n" COLOR_RESET,
                       i + 1, filtered_argc, filtered[i]);
            if (!cmd_gentoo_imitation_build(filtered[i]))
                failed++;
        }
        if (failed) {
            fprintf(stderr, COLOR_RED "\n[-] %d package(s) failed in Gentoo chroot mode.\n" COLOR_RESET, failed);
            return 1;
        }
        return 0;
    }

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
