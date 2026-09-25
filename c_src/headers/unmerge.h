/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_UNMERGE_H
#define ARCHTOO_UNMERGE_H

int  cmd_unmerge(const char *pkg);

/* Stop managing a package without uninstalling it: unlock it in pacman.conf
   and drop it from the world set. Gentoo's emerge --deselect. */
int  cmd_deselect(const char *pkg);
void unlock_pacman_pkg(const char *pkg);

#endif
