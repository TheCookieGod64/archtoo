/* SPDX-License-Identifier: GPL-3.0-or-later */
#define _POSIX_C_SOURCE 200809L

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/graph.h"

struct graph_node {
    char *name;
    char *version;
    graph_source_t source;
    size_t *dependencies;
    size_t dependency_count;
    size_t dependency_capacity;
};

struct graph {
    struct graph_node *nodes;
    size_t count;
    size_t capacity;
};

static char *copy_string(const char *value) {
    char *copy;
    if (!value) value = "";
    copy = malloc(strlen(value) + 1);
    if (copy) strcpy(copy, value);
    return copy;
}

static size_t find_node(const graph_t *graph, const char *name) {
    if (!graph || !name) return SIZE_MAX;
    for (size_t i = 0; i < graph->count; i++)
        if (strcmp(graph->nodes[i].name, name) == 0) return i;
    return SIZE_MAX;
}

graph_t *graph_create(void) {
    return calloc(1, sizeof(graph_t));
}

void graph_destroy(graph_t *graph) {
    if (!graph) return;
    for (size_t i = 0; i < graph->count; i++) {
        free(graph->nodes[i].name);
        free(graph->nodes[i].version);
        free(graph->nodes[i].dependencies);
    }
    free(graph->nodes);
    free(graph);
}

int graph_add_package(graph_t *graph, const char *name, const char *version,
                      graph_source_t source) {
    size_t existing;
    struct graph_node *grown;
    char *name_copy, *version_copy;

    if (!graph || !name || !*name) return 0;
    existing = find_node(graph, name);
    if (existing != SIZE_MAX) {
        version_copy = copy_string(version);
        if (!version_copy) return 0;
        free(graph->nodes[existing].version);
        graph->nodes[existing].version = version_copy;
        graph->nodes[existing].source = source;
        return 1;
    }
    if (graph->count == graph->capacity) {
        size_t capacity = graph->capacity ? graph->capacity * 2 : 16;
        grown = realloc(graph->nodes, capacity * sizeof(*grown));
        if (!grown) return 0;
        graph->nodes = grown;
        graph->capacity = capacity;
    }
    name_copy = copy_string(name);
    version_copy = copy_string(version);
    if (!name_copy || !version_copy) {
        free(name_copy); free(version_copy); return 0;
    }
    graph->nodes[graph->count] = (struct graph_node){
        .name = name_copy, .version = version_copy, .source = source
    };
    graph->count++;
    return 1;
}

int graph_add_dependency(graph_t *graph, const char *package,
                         const char *dependency) {
    size_t package_index, dependency_index;
    struct graph_node *node;
    size_t *grown;

    if (!graph) return 0;
    package_index = find_node(graph, package);
    dependency_index = find_node(graph, dependency);
    if (package_index == SIZE_MAX || dependency_index == SIZE_MAX) return 0;
    node = &graph->nodes[package_index];
    for (size_t i = 0; i < node->dependency_count; i++)
        if (node->dependencies[i] == dependency_index) return 1;
    if (node->dependency_count == node->dependency_capacity) {
        size_t capacity = node->dependency_capacity ? node->dependency_capacity * 2 : 8;
        grown = realloc(node->dependencies, capacity * sizeof(*grown));
        if (!grown) return 0;
        node->dependencies = grown;
        node->dependency_capacity = capacity;
    }
    node->dependencies[node->dependency_count++] = dependency_index;
    return 1;
}

int graph_has_package(const graph_t *graph, const char *name) {
    return find_node(graph, name) != SIZE_MAX;
}
size_t graph_package_count(const graph_t *graph) { return graph ? graph->count : 0; }
const char *graph_package_name(const graph_t *graph, size_t index) {
    return graph && index < graph->count ? graph->nodes[index].name : NULL;
}
const char *graph_package_version(const graph_t *graph, size_t index) {
    return graph && index < graph->count ? graph->nodes[index].version : NULL;
}
graph_source_t graph_package_source(const graph_t *graph, size_t index) {
    return graph && index < graph->count ? graph->nodes[index].source : GRAPH_SOURCE_LOCAL;
}

static int visit(const graph_t *graph, size_t index, unsigned char *state,
                 size_t *result, size_t *used, char *error, size_t error_size) {
    state[index] = 1;
    for (size_t i = 0; i < graph->nodes[index].dependency_count; i++) {
        size_t dependency = graph->nodes[index].dependencies[i];
        if (state[dependency] == 1) {
            if (error && error_size) {
                char tmp[256];
                if (snprintf(tmp, sizeof(tmp),
                             "dependency cycle detected: %s -> %s",
                             graph->nodes[index].name,
                             graph->nodes[dependency].name) < 0)
                    tmp[0] = '\0';
                size_t len = strlen(tmp);
                if (len >= error_size)
                    len = error_size - 1;
                memcpy(error, tmp, len);
                error[len] = '\0';
            }
            return 0;
        }
        if (state[dependency] == 0 &&
            !visit(graph, dependency, state, result, used, error, error_size))
            return 0;
    }
    state[index] = 2;
    result[(*used)++] = index;
    return 1;
}

int graph_topological_order(const graph_t *graph, size_t **order,
                            size_t *order_count, char *error, size_t error_size) {
    unsigned char *state;
    size_t *result, used = 0;
    if (!graph || !order || !order_count) return 0;
    *order = NULL; *order_count = 0;
    state = calloc(graph->count ? graph->count : 1, 1);
    result = malloc((graph->count ? graph->count : 1) * sizeof(*result));
    if (!state || !result) { free(state); free(result); return 0; }
    for (size_t i = 0; i < graph->count; i++) {
        if (state[i] == 0 && !visit(graph, i, state, result, &used, error, error_size)) {
            free(state); free(result); return 0;
        }
    }
    free(state);
    *order = result; *order_count = used;
    return 1;
}
