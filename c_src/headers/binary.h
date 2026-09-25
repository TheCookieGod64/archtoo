/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Binary download mode - against Gentoo principles but like yay */

#ifndef ARCHTOO_BINARY_H
#define ARCHTOO_BINARY_H

/* Try to install package as binary (no compile), with self SHA256 check.
   Returns 1 on success, 0 on failure (should fallback to source build).
   Uses only long flags: --binary etc, configured via use_binary.
   SHA256 is checked by our own implementation, not external program.
   On failure, deletes file and asks to retry with default N. */
int cmd_binary_install(const char *pkg);

#endif
