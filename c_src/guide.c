/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <errno.h>
#include <fcntl.h>
#include <pwd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "../headers/guide.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

static guide_policy_t g_policy = GUIDE_FIRST_RUN;
static int g_explicit = 0;

static int invoking_home(char *out, size_t n) {
    const char *user = build_user();
    struct passwd *pw = user ? getpwnam(user) : NULL;
    if (!pw || !pw->pw_dir)
        return 0;
    xsnprintf(out, n, "%s", pw->pw_dir);
    return 1;
}

static int state_paths(char *dir, size_t dir_n, char *marker, size_t marker_n) {
    char home[768];
    const char *xdg;

    if (!invoking_home(home, sizeof(home)))
        return 0;

    xdg = getenv("XDG_STATE_HOME");
    if (xdg && *xdg && geteuid() != 0) {
        xsnprintf(dir, dir_n, "%s/archtoo", xdg);
    } else {
        xsnprintf(dir, dir_n, "%s/.local/state/archtoo", home);
    }
    xsnprintf(marker, marker_n, "%s/command-guide-seen", dir);
    return 1;
}

int guide_policy_parse(const char *text, guide_policy_t *out) {
    if (!text || !out)
        return 0;
    if (strcmp(text, "first-run") == 0)
        *out = GUIDE_FIRST_RUN;
    else if (strcmp(text, "always") == 0)
        *out = GUIDE_ALWAYS;
    else if (strcmp(text, "never") == 0)
        *out = GUIDE_NEVER;
    else
        return 0;
    return 1;
}

const char *guide_policy_name(guide_policy_t policy) {
    switch (policy) {
    case GUIDE_FIRST_RUN: return "first-run";
    case GUIDE_ALWAYS: return "always";
    case GUIDE_NEVER: return "never";
    }
    return "first-run";
}

void guide_set_policy(guide_policy_t policy) { g_policy = policy; }
guide_policy_t guide_get_policy(void) { return g_policy; }
void guide_request_explicit(void) { g_explicit = 1; }

int guide_should_show(void) {
    char dir[1024], marker[1200];

    if (g_explicit || g_policy == GUIDE_ALWAYS)
        return 1;
    if (g_policy == GUIDE_NEVER)
        return 0;
    if (!state_paths(dir, sizeof(dir), marker, sizeof(marker)))
        return 1;
    return access(marker, F_OK) != 0;
}

void guide_print(void) {
    printf(COLOR_CYAN "\nWelcome to Archtoo.\n\n" COLOR_RESET);
    printf("Archtoo uses its own command interface. It does not copy pacman's\n");
    printf("option meanings and never invokes an external AUR helper.\n\n");
    printf("Common commands:\n\n");
    printf("  emerge -S query          Search repositories and the AUR\n");
    printf("  emerge -I package        Install a package\n");
    printf("  emerge -U                Upgrade repository and AUR packages\n");
    printf("  emerge -Q package        Query an installed package\n");
    printf("  emerge -A package        Show available package information\n");
    printf("  emerge -C package        Remove a package\n");
    printf("  emerge -G package        Download its PKGBUILD\n");
    printf("  emerge --help            Show every command\n\n");
    printf("This guide follows the '%s' display policy. Run\n",
           guide_policy_name(g_policy));
    printf("'emerge --command-guide' to display it explicitly.\n\n");
}

int guide_mark_seen(void) {
    char dir[1024], marker[1200];
    int fd;

    if (g_policy != GUIDE_FIRST_RUN || g_explicit)
        return 1;
    if (!state_paths(dir, sizeof(dir), marker, sizeof(marker)))
        return 0;

    char parent[1024];
    xsnprintf(parent, sizeof(parent), "%s", dir);
    char *slash = strrchr(parent, '/');
    if (slash) {
        *slash = '\0';
        if (mkdir(parent, 0700) != 0 && errno != EEXIST)
            return 0;
    }
    if (mkdir(dir, 0700) != 0 && errno != EEXIST)
        return 0;

    fd = open(marker, O_WRONLY | O_CREAT | O_EXCL | O_NOFOLLOW, 0600);
    if (fd < 0) {
        if (errno == EEXIST)
            return 1;
        return 0;
    }
    static const char text[] = "Archtoo command guide displayed.\n";
    ssize_t written = write(fd, text, sizeof(text) - 1);
    int saved = errno;
    close(fd);
    errno = saved;
    return written == (ssize_t)(sizeof(text) - 1);
}

int guide_maybe_show(void) {
    if (!guide_should_show())
        return 1;
    guide_print();
    if (!guide_mark_seen()) {
        fprintf(stderr, COLOR_YELLOW
                "[!] Could not record command-guide state; it may appear again.\n"
                COLOR_RESET);
    }
    return 1;
}
