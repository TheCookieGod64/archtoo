/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_UTILS_H
#define ARCHTOO_UTILS_H

#include <stddef.h>

/* snprintf that never truncates silently: if the formatted text does not
   fit (or vsnprintf fails), it prints an error and exits. A truncated shell
   command still runs -- it just does something else -- so this is always a
   programming error. */
#if defined(__GNUC__) || defined(__clang__)
int xsnprintf(char *buf, size_t n, const char *fmt, ...)
    __attribute__((format(printf, 3, 4)));
#else
int xsnprintf(char *buf, size_t n, const char *fmt, ...);
#endif

/* fopen() that refuses to follow a symlink at the final path component.
   Several files live in EMERGE_DIR, which is deliberately owned by the
   unprivileged build user; a hostile process running as that user could
   pre-plant a symlink there and a privileged fopen() would truncate or
   append to an arbitrary file. Callers that need O_EXCL (creating brand-new
   files) should use open(2) directly with the same flag. */
FILE *fopen_nofollow(const char *path, const char *mode);

/* Runs a command through the shell and returns the real exit code
   (system() hands back a wait-status word, which is not the same thing). */
int run_cmd(const char *cmd);

/* Same, but stdout and stderr are discarded. */
int run_cmd_quiet(const char *cmd);

/* If needed, invalidates cached credentials and re-executes emerge through
   sudo. The root process later drops to SUDO_USER for all build steps. */
int  acquire_sudo(int argc, char *argv[]);

int  init_system(void);
int  file_exists(const char *path);
int  dir_exists(const char *path);
const char *get_editor(void);
long get_cpu_cores(void);
void set_build_env(void);

/* default_yes is returned verbatim on EOF / non-interactive stdin, so
   destructive prompts can default to "no". */
int ask_yes_no(const char *question, int default_yes);

/* Rejects anything that is not a legal Arch package name. Everything that
   reaches a shell command must pass through this first. */
int valid_pkgname(const char *s);

/* Escapes regex metacharacters (+ . etc. are legal in package names). */
int regex_escape(const char *in, char *out, size_t n);

/* Writes a makepkg config that sources /etc/makepkg.conf and then overrides
   the optimisation flags. Returns 0 on failure. */
int write_makepkg_conf(char *path_out, size_t n);

/* "sudo " when we are not root, "" when we already are. */
const char *priv_prefix(void);

/* The unprivileged user builds must run as (makepkg refuses to run as
   root). Resolves SUDO_USER, else the current user. */
const char *build_user(void);

/* Runs cmd as build_user() when we are root, directly otherwise.
   extra_env is an optional block of "export X=y" lines, or NULL. */
int run_as_user(const char *cmd, const char *extra_env);

/* Load ~/.config/archtoo/config for the invoking user. */
void load_user_config(void);

void set_noconfirm(int v);
int  get_noconfirm(void);

/* Pacman/makepkg confirmations are disabled by default. -i/--interactive
   enables them. */
void set_interactive(int v);
int  get_interactive(void);
int  use_noconfirm(void);

/* Seconds before an Archtoo prompt chooses its default; 0 waits forever. */
void set_prompt_timeout(long seconds);
long get_prompt_timeout(void);

/* Explicit -j value; 0 means "use every core". */
void set_jobs(long n);
long get_jobs(void);

/* Reuse an existing build tree and continue an interrupted compile. */
void set_resume(int v);
int  get_resume(void);

/* Automatic PGP key import for PKGBUILDs with validpgpkeys. */
void set_import_keys(int v);
int  get_import_keys(void);

/* Keep the machine awake for the duration of a build. */
void set_inhibit(int v);
int  get_inhibit(void);

/* Run pacman -Syu as part of a world update. */
void set_sync(int v);
int  get_sync(void);

/* Hands a file back to the build user after root created it. Without this,
   a root-created file becomes unwritable by a later non-sudo run. */
void fix_owner(const char *path);

/* True if the command is resolvable on PATH. */
int have_cmd(const char *name);

#endif
