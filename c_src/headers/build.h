/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_BUILD_H
#define ARCHTOO_BUILD_H

/* Returns 1 on success, 0 on failure. */
int  cmd_build(const char *pkg);
int  fetch_sources(const char *pkg);
int  compile_package(const char *pkg);
int  lock_pacman_pkg(const char *pkg);
void cleanup_build_dir(const char *pkg);

#endif
