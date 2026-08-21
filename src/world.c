#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/world.h"
#include "../headers/build.h"
#include "../headers/utils.h"
#include "../headers/config.h"
#include "../headers/colors.h"
#include "../headers/version.h"

#define WORLD_LINE_MAX 512

int is_in_world(const char *pkg) {
    FILE *f = fopen(WORLD_FILE, "r");
    if (!f)
        return 0;

    char line[WORLD_LINE_MAX];
    int found = 0;

    while (fgets(line, sizeof(line), f)) {
        line[strcspn(line, "\r\n")] = '\0';
        if (strcmp(line, pkg) == 0) {
            found = 1;
            break;
        }
    }

    fclose(f);
    return found;
}

void add_to_world(const char *pkg) {
    if (!valid_pkgname(pkg))
        return;

    if (is_in_world(pkg))
        return;

    FILE *f = fopen(WORLD_FILE, "a");
    if (!f) {
        fprintf(stderr, COLOR_RED "[-] Could not open world file %s\n" COLOR_RESET, WORLD_FILE);
        return;
    }

    fprintf(f, "%s\n", pkg);
    fclose(f);
    printf(COLOR_GREEN "[+] %s registered in %s\n" COLOR_RESET, pkg, WORLD_FILE);
}

/* Rewrites the file in C rather than shelling out to sed, so package names
   containing regex metacharacters (gtk+, lib.foo) are handled literally. */
void remove_from_world(const char *pkg) {
    FILE *f = fopen(WORLD_FILE, "r");
    if (!f)
        return;

    char tmp[512];
    snprintf(tmp, sizeof(tmp), "%s.tmp", WORLD_FILE);

    FILE *out = fopen(tmp, "w");
    if (!out) {
        fclose(f);
        fprintf(stderr, COLOR_RED "[-] Could not update world file.\n" COLOR_RESET);
        return;
    }

    char line[WORLD_LINE_MAX];
    while (fgets(line, sizeof(line), f)) {
        char trimmed[WORLD_LINE_MAX];
        snprintf(trimmed, sizeof(trimmed), "%s", line);
        trimmed[strcspn(trimmed, "\r\n")] = '\0';

        if (strcmp(trimmed, pkg) == 0)
            continue;

        fputs(line, out);
    }

    fclose(f);
    fclose(out);

    if (rename(tmp, WORLD_FILE) != 0) {
        remove(tmp);
        fprintf(stderr, COLOR_RED "[-] Could not replace world file.\n" COLOR_RESET);
    }
}

int cmd_world_update(void) {
    printf(COLOR_PURPLE "\n==========================================================\n");
    printf("   ARCHTOO WORLD UPDATE v%s\n", ARCHTOO_VERSION);
    printf("==========================================================\n" COLOR_RESET);

    FILE *f = fopen(WORLD_FILE, "r");
    if (!f) {
        fprintf(stderr, COLOR_YELLOW "[-] No world file found.\n" COLOR_RESET);
        return 0;
    }

    /* Read the whole list first. cmd_build() appends to and rewrites the world
       file, and iterating a file whose inode is being swapped underneath you
       skips or repeats entries. */
    char **pkgs = NULL;
    size_t count = 0, cap = 0;
    char line[WORLD_LINE_MAX];

    while (fgets(line, sizeof(line), f)) {
        line[strcspn(line, "\r\n")] = '\0';
        if (line[0] == '\0' || line[0] == '#')
            continue;

        if (!valid_pkgname(line)) {
            fprintf(stderr, COLOR_RED
                    "[-] Skipping invalid entry in world file: '%s'\n" COLOR_RESET, line);
            continue;
        }

        if (count == cap) {
            size_t ncap = cap ? cap * 2 : 16;
            char **tmp = realloc(pkgs, ncap * sizeof(*pkgs));
            if (!tmp) {
                fprintf(stderr, COLOR_RED "[-] Out of memory.\n" COLOR_RESET);
                break;
            }
            pkgs = tmp;
            cap = ncap;
        }

        pkgs[count] = strdup(line);
        if (!pkgs[count])
            break;
        count++;
    }

    fclose(f);

    if (count == 0) {
        printf(COLOR_YELLOW "[-] World file is empty.\n" COLOR_RESET);
        free(pkgs);
        return 0;
    }

    size_t ok = 0, failed = 0;
    char *results = calloc(count, 1);

    for (size_t i = 0; i < count; i++) {
        printf(COLOR_YELLOW "\n>>> [WORLD %zu/%zu] Rebuilding: %s\n" COLOR_RESET,
               i + 1, count, pkgs[i]);

        int built = cmd_build(pkgs[i]);
        if (results)
            results[i] = (char)built;

        if (built)
            ok++;
        else
            failed++;
    }

    printf(COLOR_PURPLE "\n==========================================================\n" COLOR_RESET);
    if (failed == 0) {
        printf(COLOR_GREEN ">>> WORLD UPDATE COMPLETED (%zu packages)\n" COLOR_RESET, ok);
    } else {
        printf(COLOR_YELLOW ">>> WORLD UPDATE FINISHED: %zu succeeded, %zu FAILED\n" COLOR_RESET,
               ok, failed);
        if (results) {
            printf(COLOR_RED "    Failed:" COLOR_RESET);
            for (size_t i = 0; i < count; i++)
                if (!results[i])
                    printf(" %s", pkgs[i]);
            printf("\n");
        }
    }

    free(results);

    for (size_t i = 0; i < count; i++)
        free(pkgs[i]);
    free(pkgs);

    return failed == 0;
}
