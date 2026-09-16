/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_CONFIG_H
#define ARCHTOO_CONFIG_H

#include <stddef.h>

/* All paths are overridable at compile time (-D...) so the tool can be
   exercised against a scratch tree instead of the live system. */

#ifndef EMERGE_DIR
#define EMERGE_DIR   "/usr/local/emerge"
#endif

#ifndef BUILD_DIR
#define BUILD_DIR    EMERGE_DIR "/builds"
#endif

#ifndef BACKUP_DIR
#define BACKUP_DIR   EMERGE_DIR "/backups"
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

#include "guide.h"

typedef struct {
    int emerge_confirm;
    int pacman_confirm;
    long prompt_timeout;
    guide_policy_t welcome_policy;
    char aur_rpc_url[256];
    char target_arch[128];
} archtoo_config_t;

void config_defaults(archtoo_config_t *config);
int config_load(archtoo_config_t *config, char *error, size_t error_size);
const archtoo_config_t *config_current(void);
void config_apply(const archtoo_config_t *config);

#endif
