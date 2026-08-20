#ifndef ARCHTOO_BUILD_H
#define ARCHTOO_BUILD_H

void cmd_build(const char *pkg);
int fetch_sources(const char *pkg);
int compile_package(const char *pkg);
void lock_pacman_pkg(const char *pkg);
void cleanup_build_dir(const char *pkg);

#endif
