#ifndef ARCHTOO_CONFIG_H
#define ARCHTOO_CONFIG_H

#define EMERGE_DIR   "/usr/local/emerge"
#define BUILD_DIR    "/usr/local/emerge/builds"
#define WORLD_FILE   "/usr/local/emerge/world"
#define PACMAN_CONF  "/etc/pacman.conf"

#define DEFAULT_CFLAGS   "-march=native -O3 -pipe"
#define DEFAULT_CXXFLAGS "-march=native -O3 -pipe"
#define DEFAULT_KCFLAGS  "-march=native -O3 -pipe"

#endif
