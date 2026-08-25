/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "../headers/kernel.h"
#include "../headers/utils.h"
#include "../headers/colors.h"
#include "../headers/config.h"

/* Runs a command with root privileges, adding sudo only when needed. */
static int run_priv_cmd(const char *c) {
    char buf[512];
    xsnprintf(buf, sizeof(buf), "%s%s", priv_prefix(), c);
    return run_cmd(buf);
}

static int has_suffix(const char *s, const char *suf) {
    size_t ls = strlen(s), lf = strlen(suf);
    return ls > lf && strcmp(s + ls - lf, suf) == 0;
}

/* Starts with one of the non-kernel family names (at a token boundary). */
static int is_family(const char *v, const char *fam) {
    size_t l = strlen(fam);
    return strncmp(v, fam, l) == 0 && (v[l] == '\0' || v[l] == '-');
}

/* Name-based kernel heuristic. Anything that merely *starts with* "linux"
   is not a kernel: linuxcnc, linuxconsole, linux-wifi-hotspot, linux-atm,
   linux-firmware-whence all begin the same way as linux-zen. So the name
   has to be exactly "linux" or "linux-<variant>", and the variant must not
   be a known non-kernel package (or family of packages) and must not carry
   a known non-kernel suffix (-headers, -docs, ...). No list can be complete,
   which is why the *deciding* test after a build is the content check in
   pkg_ships_kernel(); this function only decides step numbering up front
   and whether -headers should be unlocked on unmerge/deselect. */
int is_kernel(const char *pkg) {
    if (strcmp(pkg, "linux") == 0)
        return 1;

    if (strncmp(pkg, "linux-", 6) != 0)
        return 0;
    const char *v = pkg + 6;
    if (*v == '\0')
        return 0;

    static const char *not_families[] = {
        "firmware", "api-headers", "tools", "docs", "wifi", "atm", NULL
    };
    for (int i = 0; not_families[i]; i++)
        if (is_family(v, not_families[i]))
            return 0;

    /* Checked against the full name, not the variant: the variant for
       linux-headers is literally "headers", which is shorter than the
       "-headers" suffix and would slip through. */
    if (has_suffix(pkg, "-headers") || has_suffix(pkg, "-docs") ||
        has_suffix(pkg, "-firmware") || has_suffix(pkg, "-whence"))
        return 0;

    return 1;
}

/* post-build check: real kernels ship usr/lib/modules/<release>/vmlinuz
   inside the built archive. Runs on the package's build tree, which makepkg
   leaves until cleanup_build_dir(); glob covers split packages (the linux
   PKGBUILD also produces linux-headers/linux-docs, which contain no vmlinuz). */
int pkg_ships_kernel(const char *pkg) {
    char cmd[1024];

    /* ^[./]* lets the leading "./" that some archivers put in members
       through; everything after still has to be usr/lib/modules/<kver>/vmlinuz. */
    xsnprintf(cmd, sizeof(cmd),
              "for f in '%s/%s'/*.pkg.tar.*; do "
              "[ -e \"$f\" ] || continue; "
              "tar -tf \"$f\" 2>/dev/null "
              "| grep -q '^[./]*usr/lib/modules/.*/vmlinuz' && exit 0; "
              "done; "
              "exit 1",
              BUILD_DIR, pkg);

    return run_cmd_quiet(cmd) == 0;
}

void run_kernel_hooks(const char *pkg) {
    printf(COLOR_PURPLE ">>> [KERNEL HOOK] Kernel detected: %s\n" COLOR_RESET, pkg);

    if (have_cmd("mkinitcpio")) {
        printf(COLOR_BLUE ">>> [KERNEL HOOK] Generating initramfs (mkinitcpio -P)...\n" COLOR_RESET);
        if (run_priv_cmd("mkinitcpio -P") != 0)
            fprintf(stderr, COLOR_RED "[-] mkinitcpio failed -- do NOT reboot yet.\n" COLOR_RESET);
    } else if (have_cmd("dracut")) {
        printf(COLOR_BLUE ">>> [KERNEL HOOK] Generating initramfs (dracut)...\n" COLOR_RESET);
        if (run_priv_cmd("dracut --regenerate-all --force") != 0)
            fprintf(stderr, COLOR_RED "[-] dracut failed -- do NOT reboot yet.\n" COLOR_RESET);
    }

    int bootloader = 0;

    if (have_cmd("grub-mkconfig") && dir_exists("/boot/grub")) {
        printf(COLOR_BLUE ">>> [KERNEL HOOK] Updating GRUB...\n" COLOR_RESET);
        if (run_priv_cmd("grub-mkconfig -o /boot/grub/grub.cfg") != 0)
            fprintf(stderr, COLOR_RED "[-] grub-mkconfig failed.\n" COLOR_RESET);
        bootloader = 1;
    }

    if (dir_exists("/boot/loader/entries") && have_cmd("bootctl")) {
        printf(COLOR_BLUE ">>> [KERNEL HOOK] systemd-boot detected.\n" COLOR_RESET);
        run_priv_cmd("bootctl update || true");
        bootloader = 1;
    }

    if (file_exists("/boot/refind_linux.conf") || dir_exists("/boot/EFI/refind")) {
        printf(COLOR_YELLOW "[!] rEFInd detected -- verify /boot/refind_linux.conf.\n" COLOR_RESET);
        bootloader = 1;
    }

    if (file_exists("/boot/limine.conf") || file_exists("/boot/limine.cfg")) {
        printf(COLOR_YELLOW "[!] Limine detected -- verify your limine config.\n" COLOR_RESET);
        bootloader = 1;
    }

    if (!bootloader)
        fprintf(stderr, COLOR_YELLOW
                "[!] No known bootloader found. Update your boot entries manually.\n" COLOR_RESET);

    if (have_cmd("sbctl"))
        printf(COLOR_YELLOW "[!] sbctl present: re-sign the new kernel if Secure Boot is on.\n"
               COLOR_RESET);

    printf(COLOR_GREEN "[+] Kernel hooks processed.\n" COLOR_RESET);
}
