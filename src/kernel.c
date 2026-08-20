#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include "../headers/kernel.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

int is_kernel(const char *pkg) {
    return (strcmp(pkg, "linux") == 0 ||
            strcmp(pkg, "linux-zen") == 0 ||
            strcmp(pkg, "linux-lts") == 0 ||
            strcmp(pkg, "linux-hardened") == 0);
}

void run_kernel_hooks(const char *pkg) {
    printf(COLOR_PURPLE ">>> [KERNEL HOOK] Kernel detected: %s\n" COLOR_RESET, pkg);

    if (access("/usr/bin/mkinitcpio", X_OK) == 0) {
        printf(COLOR_BLUE ">>> [KERNEL HOOK] Generating initramfs (mkinitcpio -P)...\n" COLOR_RESET);
        run_cmd("sudo mkinitcpio -P");
    }

    if (access("/usr/bin/grub-mkconfig", X_OK) == 0) {
        printf(COLOR_BLUE ">>> [KERNEL HOOK] Updating GRUB bootloader...\n" COLOR_RESET);
        run_cmd("sudo grub-mkconfig -o /boot/grub/grub.cfg");
    }

    printf(COLOR_GREEN "[+] Kernel hooks successfully processed!\n" COLOR_RESET);
}
