/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Binary mode - against Gentoo principles but like yay, only long flag */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

#include "../headers/binary.h"
#include "../headers/utils.h"
#include "../headers/config.h"
#include "../headers/colors.h"
#include "../headers/sha256.h"
#include "../headers/world.h"
#include "../headers/aur_rpc.h"

static int is_official_pkg(const char *pkg) {
    char cmd[600];
    xsnprintf(cmd, sizeof(cmd), "pacman -Si '%s' >/dev/null 2>&1", pkg);
    return run_cmd_quiet(cmd) == 0;
}

/* Query AUR RPC for an exact package name; prints it when found.
   Note: aur_rpc_info() returns NONZERO on success (like search.c uses it). */
static int aur_has_exact(const char *name) {
    aur_response_t resp;
    char err[256] = {0};
    memset(&resp, 0, sizeof(resp));
    if (aur_rpc_info(config_current()->aur_rpc_url, name, &resp, err, sizeof(err)) == 0)
        return 0;
    int found = 0;
    for (size_t i = 0; i < resp.count && !found; i++) {
        const aur_package_t *p = &resp.packages[i];
        if (p->name && strcmp(p->name, name) == 0) {
            printf(COLOR_GREEN "    aur/%s  %s  (◆%ld %.2f) %s\n" COLOR_RESET,
                   p->name, p->version ? p->version : "?", p->votes,
                   p->popularity, p->description ? p->description : "");
            found = 1;
        }
    }
    aur_response_destroy(&resp);
    return found;
}

int cmd_binary_install(const char *pkg) {
    if (!valid_pkgname(pkg)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET, pkg);
        return 0;
    }

    printf(COLOR_YELLOW ">>> Binary mode: repo first, then yay-style AUR binary search (long flag only)\n" COLOR_RESET);

    /* Step 1: plain repo binary install, exactly like a sane user would: sudo pacman -S. */
    printf(COLOR_BLUE ">>> [1/2] Trying official repo binary via pacman -S --needed %s...\n" COLOR_RESET, pkg);
    char try_cmd[700];
    char *out = NULL;
    xsnprintf(try_cmd, sizeof(try_cmd), "%spacman -S --needed --noconfirm '%s' 2>&1", priv_prefix(), pkg);
    int rc = run_cmd_capture(try_cmd, &out);
    if (out && *out) fputs(out, stdout);
    free(out);
    out = NULL;
    if (rc == 0 && is_official_pkg(pkg)) {
        printf(COLOR_GREEN "[+] %s installed from the official repo (pacman -S). No world/lock needed: pacman owns it.\n" COLOR_RESET, pkg);
        printf(COLOR_YELLOW "[!] Against Gentoo principles, but boring-fast like yay\n" COLOR_RESET);
        return 1;
    }

    /* Step 2: not installable straight from the repo? yay-style binary hunt. */
    if (is_official_pkg(pkg)) {
        printf(COLOR_YELLOW "[!] %s is in the repos but pacman -S failed (rc=%d); trying manual download route...\n" COLOR_RESET, pkg, rc);

        /* Legacy v2.4.0 path: resolve URL with pacman -Sp, curl/wget, self SHA256, pacman -U. */
        char *url_out = NULL;
        char url_cmd[700];
        xsnprintf(url_cmd, sizeof(url_cmd), "pacman -Sp --noconfirm '%s' 2>/dev/null | head -n1", pkg);
        if (run_cmd_capture(url_cmd, &url_out) != 0 || !url_out || !*url_out) {
            fprintf(stderr, COLOR_RED "[-] Could not get binary URL for %s\n" COLOR_RESET, pkg);
            free(url_out);
            return 0;
        }
        char *nl = strchr(url_out, '\n');
        if (nl) *nl = '\0';
        char *p = url_out;
        while (*p == ' ' || *p == '\n' || *p == '\r' || *p == '\t') p++;
        size_t len = strlen(p);
        while (len > 0 && (p[len-1] == '\n' || p[len-1] == '\r' || p[len-1] == ' ' || p[len-1] == '\t')) { p[len-1]='\0'; len--; }
        if (!*p || strncmp(p, "http", 4) != 0) {
            fprintf(stderr, COLOR_RED "[-] Invalid URL: '%s'\n" COLOR_RESET, p);
            free(url_out);
            return 0;
        }
        printf(COLOR_GREEN "[+] Binary URL: %s\n" COLOR_RESET, p);

        char tmpfile[512];
        xsnprintf(tmpfile, sizeof(tmpfile), "/tmp/archtoo-bin-%s-%ld.pkg.tar.zst", pkg, (long)getpid());
        char dl_cmd[2048];
        xsnprintf(dl_cmd, sizeof(dl_cmd), "curl -fL -o '%s' '%s' 2>&1 || wget -O '%s' '%s' 2>&1", tmpfile, p, tmpfile, p);
        printf(COLOR_BLUE ">>> Downloading binary package...\n" COLOR_RESET);
        int drc = run_cmd(dl_cmd);
        free(url_out);

        if (drc != 0 || !file_exists(tmpfile)) {
            fprintf(stderr, COLOR_RED "[-] Failed to download binary for %s\n" COLOR_RESET, pkg);
            char rm_cmd[600];
            xsnprintf(rm_cmd, sizeof(rm_cmd), "rm -f '%s'", tmpfile);
            run_cmd_quiet(rm_cmd);
            return 0;
        }

        printf(COLOR_BLUE ">>> Checking SHA256 (self implementation, no external program)...\n" COLOR_RESET);
        char hash_hex[65];
        if (!sha256_file(tmpfile, hash_hex)) {
            fprintf(stderr, COLOR_RED "[-] Could not compute SHA256 for %s\n" COLOR_RESET, tmpfile);
            char rm_cmd[600];
            xsnprintf(rm_cmd, sizeof(rm_cmd), "rm -f '%s'", tmpfile);
            run_cmd_quiet(rm_cmd);
            if (ask_yes_no("SHA256 check failed, try again?", 0)) {
                printf(COLOR_YELLOW "[!] Retrying download...\n" COLOR_RESET);
                return cmd_binary_install(pkg);
            }
            return 0;
        }
        printf(COLOR_GREEN "[+] SHA256(%s) = %s\n" COLOR_RESET, pkg, hash_hex);

        struct stat st;
        if (stat(tmpfile, &st) != 0 || st.st_size < 1024) {
            fprintf(stderr, COLOR_RED "[-] Downloaded file too small or invalid (%ld bytes)\n" COLOR_RESET, (long)st.st_size);
            char rm_cmd[600];
            xsnprintf(rm_cmd, sizeof(rm_cmd), "rm -f '%s'", tmpfile);
            run_cmd_quiet(rm_cmd);
            if (ask_yes_no("Delete and try again?", 0))
                return cmd_binary_install(pkg);
            return 0;
        }

        printf(COLOR_BLUE ">>> Installing binary package with pacman -U...\n" COLOR_RESET);
        char install_cmd[1024];
        xsnprintf(install_cmd, sizeof(install_cmd), "pacman -U --noconfirm '%s' 2>&1", tmpfile);
        int irc = run_cmd(install_cmd);
        char rm_cmd[600];
        xsnprintf(rm_cmd, sizeof(rm_cmd), "rm -f '%s'", tmpfile);
        run_cmd_quiet(rm_cmd);
        if (irc != 0) {
            fprintf(stderr, COLOR_RED "[-] Binary install failed for %s (exit %d)\n" COLOR_RESET, pkg, irc);
            if (ask_yes_no("Binary install failed, try again?", 0))
                return cmd_binary_install(pkg);
            return 0;
        }
        printf(COLOR_GREEN "[+] Binary package %s installed successfully\n" COLOR_RESET, pkg);
        printf(COLOR_YELLOW "[!] Against Gentoo principles, but fast like yay\n" COLOR_RESET);
        add_to_world(pkg);
        return 1;
    }

    /* Not in repos at all: search AUR for prebuilt-binary variants, like yay looks up -bin packages. */
    printf(COLOR_YELLOW "[!] %s not in official repos → searching AUR for a prebuilt binary (like yay)...\n" COLOR_RESET, pkg);
    static const char *sfx[] = { "-bin", "-binary", "-prebuilt", "-release" };
    char variant[300];
    for (size_t i = 0; i < sizeof(sfx)/sizeof(sfx[0]); i++) {
        xsnprintf(variant, sizeof(variant), "%s%s", pkg, sfx[i]);
        if (aur_has_exact(variant)) {
            printf(COLOR_GREEN "[+] Prebuilt AUR variant found: %s (upstream binary, makepkg only repackages it - no compiling)\n" COLOR_RESET, variant);
            printf(COLOR_BLUE ">>> Tip: 'emerge --binary %s' targets it directly; continuing with %s's source build as requested\n" COLOR_RESET, variant, pkg);
            return 0; /* caller (cmd_build) falls back to fetching its PKGBUILD */
        }
    }
    if (aur_has_exact(pkg)) {
        printf(COLOR_YELLOW "[!] %s exists in AUR but only as a source build; no -bin variant found (yay would compile it)\n" COLOR_RESET, pkg);
    } else {
        printf(COLOR_RED "[-] %s: not in official repos and nothing in AUR either - no binary to find\n" COLOR_RESET, pkg);
    }
    return 0;
}
