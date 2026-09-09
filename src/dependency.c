/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/operations.h"
#include "../headers/aur_rpc.h"
#include "../headers/config.h"
#include "../headers/graph.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

static void print_dep_list(const char *label, char **items, size_t count) {
    printf("  %-14s", label);
    if (count == 0) {
        printf("(none)\n");
        return;
    }
    for (size_t i = 0; i < count; i++)
        printf("%s%s", i ? "  " : "", items[i]);
    putchar('\n');
}

static void add_dep_nodes(graph_t *graph, const char *pkg,
                          char **items, size_t count) {
    for (size_t i = 0; i < count; i++) {
        char base[160];
        dep_basename(items[i], base, sizeof(base));
        if (!base[0] || !valid_pkgname(base))
            continue;
        if (!graph_has_package(graph, base))
            graph_add_package(graph, base, "", GRAPH_SOURCE_REPOSITORY);
        graph_add_dependency(graph, pkg, base);
    }
}

static int plan_from_aur(const char *name) {
    aur_response_t response = {0};
    char error[256] = "";
    graph_t *graph;
    size_t *order = NULL, order_count = 0;
    int ok = 0;

    if (!aur_rpc_info(config_current()->aur_rpc_url, name, &response,
                      error, sizeof(error)) || response.count == 0) {
        aur_response_destroy(&response);
        return 0;
    }

    graph = graph_create();
    if (!graph) {
        aur_response_destroy(&response);
        return 0;
    }

    for (size_t i = 0; i < response.count; i++) {
        const aur_package_t *p = &response.packages[i];
        const char *pkg = p->name ? p->name : name;

        graph_add_package(graph, pkg, p->version ? p->version : "",
                          GRAPH_SOURCE_AUR);
        printf(COLOR_CYAN "Package: %s %s (aur)\n" COLOR_RESET,
               pkg, p->version ? p->version : "");
        print_dep_list("Depends:", p->depends, p->depends_count);
        print_dep_list("MakeDepends:", p->make_depends, p->make_depends_count);
        print_dep_list("CheckDepends:", p->check_depends, p->check_depends_count);
        add_dep_nodes(graph, pkg, p->depends, p->depends_count);
        add_dep_nodes(graph, pkg, p->make_depends, p->make_depends_count);
        add_dep_nodes(graph, pkg, p->check_depends, p->check_depends_count);
    }

    printf(COLOR_CYAN "Install order (dependency-first):\n" COLOR_RESET);
    if (graph_topological_order(graph, &order, &order_count, error, sizeof(error))) {
        for (size_t i = 0; i < order_count; i++) {
            const char *n = graph_package_name(graph, order[i]);
            const char *v = graph_package_version(graph, order[i]);
            graph_source_t src = graph_package_source(graph, order[i]);
            printf("  %zu. %s%s%s  [%s]\n", i + 1, n ? n : "?",
                   (v && *v) ? " " : "", (v && *v) ? v : "",
                   src == GRAPH_SOURCE_AUR ? "aur" : "repo/dep");
        }
        ok = 1;
    } else {
        fprintf(stderr, COLOR_RED "[-] %s\n" COLOR_RESET, error);
    }
    free(order);
    graph_destroy(graph);
    aur_response_destroy(&response);
    return ok;
}

static int plan_from_repo(const char *name) {
    char quoted[320];
    char cmd[512];
    char *out = NULL;
    char *depends = NULL, *opt = NULL, *maked = NULL, *checkd = NULL;
    char *ver = NULL, *repo = NULL;
    int rc;

    if (!shell_quote(name, quoted, sizeof(quoted)))
        return 0;
    xsnprintf(cmd, sizeof(cmd), "pacman -Si -- %s", quoted);
    rc = run_cmd_capture(cmd, &out);
    if (rc != 0 || !out || !*out) {
        free(out);
        return 0;
    }

    {
        char *line = out;
        while (line && *line) {
            char *nl = strchr(line, '\n');
            char *colon;
            if (nl)
                *nl = '\0';
            colon = strchr(line, ':');
            if (colon) {
                *colon = '\0';
                if (strncmp(line, "Version", 7) == 0)
                    ver = colon + 1;
                else if (strncmp(line, "Repository", 10) == 0)
                    repo = colon + 1;
                else if (strncmp(line, "Depends On", 10) == 0)
                    depends = colon + 1;
                else if (strncmp(line, "Optional Deps", 13) == 0)
                    opt = colon + 1;
                else if (strncmp(line, "Make Deps", 9) == 0 ||
                         strncmp(line, "Build Deps", 10) == 0)
                    maked = colon + 1;
                else if (strncmp(line, "Check Deps", 10) == 0)
                    checkd = colon + 1;
            }
            if (!nl)
                break;
            line = nl + 1;
        }
    }

    while (ver && (*ver == ' ' || *ver == '\t')) ver++;
    while (repo && (*repo == ' ' || *repo == '\t')) repo++;
    while (depends && (*depends == ' ' || *depends == '\t')) depends++;
    while (opt && (*opt == ' ' || *opt == '\t')) opt++;
    while (maked && (*maked == ' ' || *maked == '\t')) maked++;
    while (checkd && (*checkd == ' ' || *checkd == '\t')) checkd++;

    printf(COLOR_CYAN "Package: %s %s (%s)\n" COLOR_RESET,
           name, ver ? ver : "", repo && *repo ? repo : "repo");
    printf("  %-14s%s\n", "Depends:",
           (depends && *depends && strcmp(depends, "None") != 0) ? depends : "(none)");
    printf("  %-14s%s\n", "MakeDepends:",
           (maked && *maked && strcmp(maked, "None") != 0) ? maked : "(none)");
    printf("  %-14s%s\n", "CheckDepends:",
           (checkd && *checkd && strcmp(checkd, "None") != 0) ? checkd : "(none)");
    printf("  %-14s%s\n", "Optional:",
           (opt && *opt && strcmp(opt, "None") != 0) ? opt : "(none)");
    printf(COLOR_CYAN "Install order (dependency-first):\n" COLOR_RESET);

    {
        graph_t *graph = graph_create();
        char error[256] = "";
        size_t *order = NULL, order_count = 0;

        if (graph) {
            graph_add_package(graph, name, ver ? ver : "", GRAPH_SOURCE_REPOSITORY);
            if (depends && *depends && strcmp(depends, "None") != 0) {
                char *copy = strdup(depends);
                char *tok, *save = NULL;
                if (copy) {
                    for (tok = strtok_r(copy, " \t", &save); tok;
                         tok = strtok_r(NULL, " \t", &save)) {
                        char base[160];
                        dep_basename(tok, base, sizeof(base));
                        if (base[0] && valid_pkgname(base)) {
                            if (!graph_has_package(graph, base))
                                graph_add_package(graph, base, "",
                                                  GRAPH_SOURCE_REPOSITORY);
                            graph_add_dependency(graph, name, base);
                        }
                    }
                    free(copy);
                }
            }
            if (graph_topological_order(graph, &order, &order_count,
                                        error, sizeof(error))) {
                for (size_t i = 0; i < order_count; i++)
                    printf("  %zu. %s\n", i + 1,
                           graph_package_name(graph, order[i]));
            } else {
                printf("  1. %s\n", name);
            }
            free(order);
            graph_destroy(graph);
        }
    }
    free(out);
    return 1;
}

int cmd_dependency_plan_v2(const char *name) {
    if (!valid_pkgname(name)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET,
                name ? name : "");
        return 0;
    }
    if (plan_from_repo(name))
        return 1;
    if (plan_from_aur(name))
        return 1;
    fprintf(stderr, COLOR_RED "[-] Could not resolve dependencies for '%s'.\n"
            COLOR_RESET, name);
    return 0;
}
