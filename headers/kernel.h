/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_KERNEL_H
#define ARCHTOO_KERNEL_H

int is_kernel(const char *pkg);
void run_kernel_hooks(const char *pkg);

#endif
