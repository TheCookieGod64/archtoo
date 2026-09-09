/* SPDX-License-Identifier: GPL-3.0-or-later */
#ifndef ARCHTOO_AUR_RPC_H
#define ARCHTOO_AUR_RPC_H

#include <stddef.h>

typedef struct {
    char *name;
    char *package_base;
    char *version;
    char *description;
    char *url;
    char *maintainer;
    long votes;
    double popularity;
    long out_of_date;
    char **depends;
    size_t depends_count;
    char **make_depends;
    size_t make_depends_count;
    char **check_depends;
    size_t check_depends_count;
    char **provides;
    size_t provides_count;
    char **conflicts;
    size_t conflicts_count;
} aur_package_t;

typedef struct {
    aur_package_t *packages;
    size_t count;
} aur_response_t;

void aur_response_destroy(aur_response_t *response);
int aur_rpc_search(const char *base_url, const char *query,
                   aur_response_t *response, char *error, size_t error_size);
int aur_rpc_info(const char *base_url, const char *name,
                 aur_response_t *response, char *error, size_t error_size);

#endif
