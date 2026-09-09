/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_KERNEL_H
#define ARCHTOO_KERNEL_H

/* Name heuristic: exactly "linux" or "linux-<variant>" with no known
   non-kernel family/suffix. Used for step numbering and for deciding what
   to unlock on unmerge/deselect -- see pkg_ships_kernel() for the test that
   actually gates the hooks after a build. */
int is_kernel(const char *pkg);

/* Content check, run after a build: true if any built archive of the
   package contains usr/lib/modules/<kver>/vmlinuz. */
int pkg_ships_kernel(const char *pkg);

void run_kernel_hooks(const char *pkg);

#endif
