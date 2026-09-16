/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>

#include "../headers/operations.h"
#include "../headers/utils.h"

int cmd_completion_v2(void) {
    static const char *flags[] = {
        "-S", "-I", "-Q", "-A", "-G", "-B", "-C", "-U", "-D", "-v", "-h",
        "-i", "-j", "-r",
        "-O0", "-O1", "-O2", "-O3", "-Os", "-Ofast", "-Og", "-Oz",
        "--help", "--version", "--noconfirm", "--interactive",
        "--prompt-timeout", "--jobs", "--target", "--march", "--cpu",
        "--opt-level", "--opt", "--optimization", "--pipe", "--no-pipe",
        "--resume", "--no-keys", "--no-inhibit",
        "--no-sync", "--no-aur-sync", "--command-guide", "--orphans",
        "--clean", "--stats", "--news", "--complete", "--devel",
        "--providers", "--deps", "--review", "--unmerge", "--deselect",
        "--update", NULL
    };
    char *out = NULL;
    int rc;

    for (int i = 0; flags[i]; i++)
        puts(flags[i]);

    rc = run_cmd_capture("pacman -Slq 2>/dev/null | sort -u", &out);
    if (rc == 0 && out && *out)
        fputs(out, stdout);
    free(out);
    return 1;
}
