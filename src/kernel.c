/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "../headers/kernel.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

/* Runs a command with root privileges, adding sudo only when needed. */
static int run_priv_cmd(const char *c) {
    char buf[512];
    snprintf(buf, sizeof(buf), "%s%s", priv_prefix(), c);
    return run_cmd(buf);
}

static int has_suffix(const char *s, const char *suf) {
    size_t ls = strlen(s), lf = strlen(suf);
    return ls > lf && strcmp(s + ls - lf, suf) == 0;
}

int is_kernel(const char *pkg) {
    /* Prefix match so linux-rt, linux-xanmod, linux-zen-git, ... are covered
       instead of only the four names that used to be hardcoded. */
    static const char *not_kernels[] = {
        "linux-firmware", "linux-api-headers", "linux-tools", "linux-docs", NULL
    };

    if (strncmp(pkg, "linux", 5) != 0)
        return 0;

    for (int i = 0; not_kernels[i]; i++)
        if (strcmp(pkg, not_kernels[i]) == 0)
            return 0;

    if (has_suffix(pkg, "-headers") || has_suffix(pkg, "-docs") ||
        has_suffix(pkg, "-firmware"))
        return 0;

    return 1;
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
