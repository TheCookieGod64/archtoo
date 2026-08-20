#ifndef ARCHTOO_UTILS_H
#define ARCHTOO_UTILS_H

int run_cmd(const char *cmd);
void init_system(void);
int file_exists(const char *path);
int dir_exists(const char *path);
char *get_editor(void);
long get_cpu_cores(void);
void set_build_env(void);
int ask_yes_no(const char *question);

#endif
