/* SPDX-License-Identifier: GPL-3.0-or-later */
#define _POSIX_C_SOURCE 200809L

#include <ctype.h>
#include <errno.h>
#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>

#include "../headers/config.h"
#include "../headers/guide.h"
#include "../headers/utils.h"

static archtoo_config_t g_config;
static int g_initialized = 0;

static __attribute__((noinline)) void error_format(char *error, size_t n,
                                                    const char *fmt, ...) {
    va_list ap;
    if (!error || n == 0) return;
    va_start(ap, fmt);
    (void)vsnprintf(error, n, fmt, ap);
    va_end(ap);
}

static char *trim(char *text) {
    char *end;
    while (isspace((unsigned char)*text)) text++;
    end = text + strlen(text);
    while (end > text && isspace((unsigned char)end[-1])) end--;
    *end = '\0';
    return text;
}

static int parse_switch(const char *value, int *out) {
    if (strcmp(value, "true") == 0 || strcmp(value, "yes") == 0 || strcmp(value, "enabled") == 0) *out = 1;
    else if (strcmp(value, "false") == 0 || strcmp(value, "no") == 0 || strcmp(value, "disabled") == 0) *out = 0;
    else return 0;
    return 1;
}

void config_defaults(archtoo_config_t *config) {
    if (!config) return;
    memset(config, 0, sizeof(*config));
    config->emerge_confirm = 1;
    config->pacman_confirm = 0;
    config->prompt_timeout = 300;
    config->welcome_policy = GUIDE_FIRST_RUN;
    snprintf(config->aur_rpc_url, sizeof(config->aur_rpc_url),
             "https://aur.archlinux.org/rpc/v5");
    snprintf(config->target_arch, sizeof(config->target_arch), "native");
    snprintf(config->opt_level, sizeof(config->opt_level), "3");
    config->use_pipe = 1;
    config->has_pipe_setting = 0;
    config->gentoo_chroot = 0;
    config->portage_imitation = 0;
    snprintf(config->gentoo_chroot_path, sizeof(config->gentoo_chroot_path),
             "%s/gentoo-chroot", EMERGE_DIR);
}

static int config_path(char *path, size_t n) {
    const char *user = build_user();
    struct passwd *pw = user ? getpwnam(user) : NULL;
    const char *xdg = getenv("XDG_CONFIG_HOME");
    if (!pw || !pw->pw_dir) return 0;
    if (xdg && *xdg && geteuid() != 0) snprintf(path, n, "%s/archtoo/config", xdg);
    else snprintf(path, n, "%s/.config/archtoo/config", pw->pw_dir);
    return 1;
}

int config_load(archtoo_config_t *config, char *error, size_t error_size) {
    char path[1024], line[1024];
    unsigned long line_number = 0;
    FILE *file;
    if (!config) return 0;
    config_defaults(config);
    if (!config_path(path, sizeof(path))) {
        error_format(error,error_size,"cannot determine invoking user's config path");
        return 0;
    }
    file = fopen(path, "r");
    if (!file) {
        if (errno == ENOENT) return 1;
        error_format(error,error_size,"cannot open config: %s",strerror(errno));
        return 0;
    }
    while (fgets(line, sizeof(line), file)) {
        char *key, *value, *equals;
        long number; char *end;
        line_number++;
        key = trim(line);
        if (!*key || *key == '#') continue;
        equals = strchr(key, '=');
        if (!equals) {
            error_format(error,error_size,"config line %lu has no '='",line_number);
            fclose(file); return 0;
        }
        *equals = '\0'; value = trim(equals + 1); key = trim(key);
        char *comment = strchr(value, '#'); if (comment) { *comment='\0'; value=trim(value); }
        if (strcmp(key,"emerge_confirm")==0) {
            if(!parse_switch(value,&config->emerge_confirm)) goto invalid;
        } else if (strcmp(key,"pacman_confirm")==0) {
            if(!parse_switch(value,&config->pacman_confirm)) goto invalid;
        } else if (strcmp(key,"prompt_timeout")==0) {
            errno=0; number=strtol(value,&end,10);
            if(errno||*end||number<0||number>86400) goto invalid;
            config->prompt_timeout=number;
        } else if (strcmp(key,"welcome_policy")==0 || strcmp(key,"command_guide")==0) {
            if(!guide_policy_parse(value,&config->welcome_policy)) goto invalid;
        } else if (strcmp(key,"aur_rpc_url")==0) {
            if(strncmp(value,"https://",8)!=0 || strlen(value)>=sizeof(config->aur_rpc_url)) goto invalid;
            snprintf(config->aur_rpc_url,sizeof(config->aur_rpc_url),"%s",value);
        } else if (strcmp(key,"target_arch")==0 || strcmp(key,"target")==0 ||
                   strcmp(key,"march")==0 || strcmp(key,"cpu")==0) {
            if (!valid_target_arch(value)) goto invalid;
            if (strlen(value) >= sizeof(config->target_arch)) goto invalid;
            snprintf(config->target_arch, sizeof(config->target_arch), "%s", value);
        } else if (strcmp(key,"opt_level")==0 || strcmp(key,"opt")==0 ||
                   strcmp(key,"optimization")==0 || strcmp(key,"o")==0) {
            if (!valid_opt_level(value)) goto invalid;
            if (strlen(value) >= sizeof(config->opt_level)) {
                if (strlen(value) > 16) goto invalid;
            }
            const char *p = value;
            if (*p == '-') p++;
            if (*p == 'O' || *p == 'o') p++;
            snprintf(config->opt_level, sizeof(config->opt_level), "%s", p);
        } else if (strcmp(key,"pipe")==0 || strcmp(key,"use_pipe")==0) {
            int v;
            if (!parse_switch(value, &v)) goto invalid;
            config->use_pipe = v;
            config->has_pipe_setting = 1;
        } else if (strcmp(key,"gentoo_chroot")==0 || strcmp(key,"portage_chroot")==0 ||
                   strcmp(key,"imitation")==0 || strcmp(key,"portage_imitation")==0 ||
                   strcmp(key,"gentoo_imitation")==0) {
            int v;
            if (!parse_switch(value, &v)) goto invalid;
            config->gentoo_chroot = v;
            config->portage_imitation = v;
        } else if (strcmp(key,"gentoo_chroot_path")==0 || strcmp(key,"chroot_path")==0) {
            if (!valid_gentoo_chroot_path(value)) goto invalid;
            snprintf(config->gentoo_chroot_path, sizeof(config->gentoo_chroot_path), "%s", value);
        } else {
            error_format(error,error_size,"unknown config key on line %lu: %s",line_number,key);
            fclose(file); return 0;
        }
        continue;
invalid:
        error_format(error,error_size,"invalid value for %s on line %lu: %s",key,line_number,value);
        fclose(file); return 0;
    }
    if (ferror(file)) { error_format(error,error_size,"error reading config: %s",strerror(errno)); fclose(file); return 0; }
    fclose(file); return 1;
}

void config_apply(const archtoo_config_t *config) {
    if (!config) return;
    g_config = *config; g_initialized = 1;
    set_interactive(config->pacman_confirm);
    set_prompt_timeout(config->prompt_timeout);
    set_emerge_confirm(config->emerge_confirm);
    guide_set_policy(config->welcome_policy);
    if (config->target_arch[0]) {
        set_target_arch(config->target_arch);
    }
    if (config->opt_level[0]) {
        set_opt_level(config->opt_level);
    }
    if (config->has_pipe_setting) {
        set_use_pipe(config->use_pipe);
    }
    if (config->gentoo_chroot) {
        set_gentoo_chroot(config->gentoo_chroot);
        set_portage_imitation(config->portage_imitation);
    }
    if (config->gentoo_chroot_path[0]) {
        set_gentoo_chroot_path(config->gentoo_chroot_path);
    }
}

const archtoo_config_t *config_current(void) {
    if (!g_initialized) { config_defaults(&g_config); g_initialized=1; }
    return &g_config;
}
