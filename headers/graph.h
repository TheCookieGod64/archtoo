/* SPDX-License-Identifier: GPL-3.0-or-later */
#ifndef ARCHTOO_GRAPH_H
#define ARCHTOO_GRAPH_H

#include <stddef.h>

typedef enum {
    GRAPH_SOURCE_REPOSITORY = 0,
    GRAPH_SOURCE_AUR,
    GRAPH_SOURCE_LOCAL
} graph_source_t;

typedef struct graph graph_t;

graph_t *graph_create(void);
void graph_destroy(graph_t *graph);
int graph_add_package(graph_t *graph, const char *name, const char *version,
                      graph_source_t source);
int graph_add_dependency(graph_t *graph, const char *package,
                         const char *dependency);
int graph_has_package(const graph_t *graph, const char *name);
size_t graph_package_count(const graph_t *graph);
const char *graph_package_name(const graph_t *graph, size_t index);
const char *graph_package_version(const graph_t *graph, size_t index);
graph_source_t graph_package_source(const graph_t *graph, size_t index);
/* Returns a heap-allocated array of package indices in dependency-first order.
   The caller frees *order. Returns 0 and writes a cycle description on cycles. */
int graph_topological_order(const graph_t *graph, size_t **order,
                            size_t *order_count, char *error, size_t error_size);

#endif
