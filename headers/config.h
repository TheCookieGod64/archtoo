/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_CONFIG_H
#define ARCHTOO_CONFIG_H

/* All paths are overridable at compile time (-D...) so the tool can be
   exercised against a scratch tree instead of the live system. */

#ifndef EMERGE_DIR
#define EMERGE_DIR   "/usr/local/emerge"
#endif

#ifndef BUILD_DIR
#define BUILD_DIR    EMERGE_DIR "/builds"
#endif

#ifndef WORLD_FILE
#define WORLD_FILE   EMERGE_DIR "/world"
#endif

#ifndef PACMAN_CONF
#define PACMAN_CONF  "/etc/pacman.conf"
#endif

#define DEFAULT_CFLAGS   "-march=native -O3 -pipe"
#define DEFAULT_CXXFLAGS "-march=native -O3 -pipe"
#define DEFAULT_KCFLAGS  "-march=native -O3 -pipe"

#endif
