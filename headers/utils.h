#ifndef ARCHTOO_UTILS_H
#define ARCHTOO_UTILS_H

#include <stddef.h>

/* Runs a command through the shell and returns the real exit code
   (system() hands back a wait-status word, which is not the same thing). */
int run_cmd(const char *cmd);

/* Same, but stdout and stderr are discarded. */
int run_cmd_quiet(const char *cmd);

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

void set_noconfirm(int v);
int  get_noconfirm(void);

#endif
