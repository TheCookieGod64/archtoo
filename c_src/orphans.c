/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/operations.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

int cmd_orphans_v2(void) {
    char *out = NULL;
    int rc = run_cmd_capture("pacman -Qdtq", &out);

    /* pacman returns 1 when the filter matches nothing. */
    if ((rc == 0 || rc == 1) && (!out || !*out)) {
        printf("No orphaned packages.\n");
        free(out);
        return 1;
    }
    if (rc != 0) {
        fprintf(stderr, COLOR_RED "[-] Could not query orphaned packages.\n"
                COLOR_RESET);
        free(out);
        return 0;
    }
    printf(COLOR_CYAN ">>> Orphaned dependencies (installed as deps, required by none)\n"
           COLOR_RESET);
    fputs(out, stdout);
    if (out[strlen(out) - 1] != '\n')
        putchar('\n');
    free(out);
    return 1;
}
