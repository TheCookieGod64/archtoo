/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Binary download mode - against Gentoo principles but like yay */

#ifndef ARCHTOO_BINARY_H
#define ARCHTOO_BINARY_H

#include <stddef.h>

/* Try to install package as binary (no compile), with self SHA256 check.
   Uses only long flags: --binary etc, configured via use_binary.
   SHA256 is checked by our own implementation, not external program.
   On failure, deletes file and asks to retry with default N.

   Return values:
     1 = binary package was installed; nothing else to do.
     2 = --binary resolved the request to a concrete package (possibly the
         prebuilt "-bin" variant) that should be handed to the source path
         directly, without the "binary install failed" nag or the
         continue-prompt. *chosen (when non-NULL) receives that name.
     0 = no binary path found; caller may offer a source-build fallback. */
int cmd_binary_install(const char *pkg, char *chosen, size_t chosen_sz);

#endif
