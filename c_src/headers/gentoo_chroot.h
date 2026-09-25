/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Gentoo chroot imitation mode - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_GENTOO_CHROOT_H
#define ARCHTOO_GENTOO_CHROOT_H

/* Returns 1 if chroot exists and looks like Gentoo */
int gentoo_chroot_exists(const char *path);

/* Download latest stage3 and extract to path (persistent mode).
   Returns 1 on success, 0 on failure. */
int gentoo_chroot_init(const char *path);

/* Mount required pseudo-filesystems and bind mounts for Archtoo integration.
   Mounts: proc, sys, dev, run, tmp, plus BUILD_DIR, BACKUP_DIR, WORLD_FILE etc.
   Returns 1 on success. */
int gentoo_chroot_mount(const char *path);

/* Unmount everything mounted by gentoo_chroot_mount.
   Returns 1 on success (best effort). */
int gentoo_chroot_unmount(const char *path);

/* Run real Portage emerge inside chroot and forward STDOUT/STDERR directly
   to host STDOUT. Handles SIGINT for cleanup.
   Returns exit code of Portage (0 success). */
int gentoo_chroot_run_portage(const char *chroot_path, const char *pkg, int jobs);

/* Full flow: ensure chroot exists, mount, run portage, handle binary backup mount,
   unmount, and cleanup chroot handle as if nothing happened.
   This is the SUPER HARD IMITATION like real Portage.
   Returns 1 on success, 0 on failure. */
int cmd_gentoo_imitation_build(const char *pkg);

#endif
