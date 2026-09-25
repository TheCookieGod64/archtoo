/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>

#include "../headers/operations.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

int cmd_transaction_check_v2(void) {
    if (file_exists("/var/lib/pacman/db.lck")) {
        fprintf(stderr, COLOR_RED
                "[-] pacman database is locked (/var/lib/pacman/db.lck).\n"
                "    Another pacman/emerge transaction is running, or a previous\n"
                "    one was interrupted. Remove the lock only if you are sure\n"
                "    nothing else is using pacman.\n" COLOR_RESET);
        return 0;
    }
    printf(COLOR_GREEN "[+] pacman database is not locked.\n" COLOR_RESET);
    return 1;
}
