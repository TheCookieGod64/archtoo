#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/world.h"
#include "../headers/build.h"
#include "../headers/utils.h"
#include "../headers/config.h"
#include "../headers/colors.h"
#include "../headers/version.h"

int is_in_world(const char *pkg) {
    char cmd[512];
    snprintf(cmd, sizeof(cmd), "grep -q -x \"%s\" %s", pkg, WORLD_FILE);
    return run_cmd(cmd) == 0;
}

void add_to_world(const char *pkg) {
    if (is_in_world(pkg))
        return;

    FILE *f = fopen(WORLD_FILE, "a");
    if (!f) {
        printf(COLOR_RED "[-] Could not open world file!\n" COLOR_RESET);
        return;
    }

    fprintf(f, "%s\n", pkg);
    fclose(f);
    printf(COLOR_GREEN "[+] %s registered in %s\n" COLOR_RESET, pkg, WORLD_FILE);
}

void remove_from_world(const char *pkg) {
    char cmd[512];
    snprintf(cmd, sizeof(cmd), "sed -i \"/^%s$/d\" %s", pkg, WORLD_FILE);
    run_cmd(cmd);
}

void cmd_world_update(void) {
    printf(COLOR_PURPLE "\n==========================================================\n");
    printf("   ARCHTOO WORLD UPDATE v%s\n", ARCHTOO_VERSION);
    printf("==========================================================\n" COLOR_RESET);

    FILE *f = fopen(WORLD_FILE, "r");
    if (!f) {
        printf(COLOR_YELLOW "[-] No world file found.\n" COLOR_RESET);
        return;
    }

    char line[256];
    int count = 0;

    while (fgets(line, sizeof(line), f)) {
        line[strcspn(line, "\r\n")] = 0;
        if (strlen(line) == 0)
            continue;

        count++;
        printf(COLOR_YELLOW "\n>>> [WORLD] Rebuilding: %s\n" COLOR_RESET, line);
        cmd_build(line);
    }

    fclose(f);

    if (count == 0)
        printf(COLOR_YELLOW "[-] World file is empty.\n" COLOR_RESET);
    else
        printf(COLOR_GREEN "\n>>> WORLD UPDATE COMPLETED (%d packages)\n" COLOR_RESET, count);
}
