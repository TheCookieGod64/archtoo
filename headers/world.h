/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_WORLD_H
#define ARCHTOO_WORLD_H

void add_to_world(const char *pkg);
void remove_from_world(const char *pkg);
int  is_in_world(const char *pkg);
int  cmd_world_update(void);

#endif
