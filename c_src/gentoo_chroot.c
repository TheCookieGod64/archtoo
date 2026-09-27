/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Gentoo chroot imitation mode - The best feature ever */

#define _POSIX_C_SOURCE 200809L

#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/wait.h>

#include "../headers/gentoo_chroot.h"
#include "../headers/config.h"
#include "../headers/utils.h"
#include "../headers/colors.h"
#include "../headers/build.h"
#include "../headers/world.h"

static volatile sig_atomic_t g_chroot_interrupted = 0;
static char g_chroot_path_store[512] = {0};

static void chroot_signal_handler(int sig) {
    (void)sig;
    g_chroot_interrupted = 1;
}

static void arm_chroot_signals(void) {
    struct sigaction sa;
    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = chroot_signal_handler;
    sigemptyset(&sa.sa_mask);
    sigaction(SIGINT, &sa, NULL);
    sigaction(SIGTERM, &sa, NULL);
    sigaction(SIGHUP, &sa, NULL);
}

int gentoo_chroot_exists(const char *path) {
    if (!path || !*path) return 0;
    char check[1024];
    xsnprintf(check, sizeof(check), "%s/etc/gentoo-release", path);
    if (file_exists(check)) return 1;
    xsnprintf(check, sizeof(check), "%s/etc/os-release", path);
    if (!file_exists(check)) return 0;
    char cmd[1150];
    xsnprintf(cmd, sizeof(cmd), "grep -q Gentoo '%s' 2>/dev/null", check);
    return run_cmd_quiet(cmd) == 0;
}

int gentoo_chroot_init(const char *path) {
    if (!path || !valid_gentoo_chroot_path(path)) {
        fprintf(stderr, COLOR_RED "[-] Invalid chroot path: %s\n" COLOR_RESET, path ? path : "(null)");
        return 0;
    }

    if (gentoo_chroot_exists(path)) {
        printf(COLOR_GREEN "[+] Gentoo chroot already exists at %s (persistent mode)\n" COLOR_RESET, path);
        return 1;
    }

    printf(COLOR_CYAN ">>> Initializing chroot at %s...\n" COLOR_RESET, path);

    char cmd[4096];

    xsnprintf(cmd, sizeof(cmd), "%smkdir -p '%s'", priv_prefix(), path);
    if (run_cmd(cmd) != 0) {
        fprintf(stderr, COLOR_RED "[-] Cannot create chroot dir %s\n" COLOR_RESET, path);
        return 0;
    }

    printf(COLOR_BLUE ">>> Fetching latest Gentoo stage3 URL...\n" COLOR_RESET);
    char *latest_file = NULL;
    const char *fetch_latest =
        "curl -fsSL https://distfiles.gentoo.org/releases/amd64/autobuilds/latest-stage3-amd64-openrc.txt 2>/dev/null "
        "| grep -E 'stage3-amd64-openrc.*\\.tar\\.xz' | grep -v '^#' | grep -v 'BEGIN' | head -n1 | awk '{print $1}'";
    int rc = run_cmd_capture(fetch_latest, &latest_file);
    char stage3_url[1024] = {0};
    int use_fallback = 1;
    if (rc == 0 && latest_file && *latest_file) {
        char *p = latest_file;
        while (*p && (*p == ' ' || *p == '\n' || *p == '\r' || *p == '\t')) p++;
        size_t len = strlen(p);
        while (len > 0 && (p[len-1] == '\n' || p[len-1] == '\r' || p[len-1] == ' ' || p[len-1] == '\t')) { p[len-1]='\0'; len--; }
        if (strstr(p, "BEGIN") == NULL && strstr(p, ".tar") != NULL && strlen(p) > 10) {
            if (strncmp(p, "https://", 8) == 0) {
                xsnprintf(stage3_url, sizeof(stage3_url), "%s", p);
            } else {
                xsnprintf(stage3_url, sizeof(stage3_url), "https://distfiles.gentoo.org/releases/amd64/autobuilds/%s", p);
            }
            printf(COLOR_GREEN "[+] Latest stage3: %s\n" COLOR_RESET, stage3_url);
            use_fallback = 0;
        }
    }
    free(latest_file);
    latest_file = NULL;

    if (use_fallback) {
        printf(COLOR_YELLOW "[!] Could not fetch latest list, using fallback\n" COLOR_RESET);
        xsnprintf(stage3_url, sizeof(stage3_url),
                  "https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/stage3-amd64-openrc-latest.tar.xz");
        char check_cmd[1200];
        xsnprintf(check_cmd, sizeof(check_cmd), "curl -fsI '%s' >/dev/null 2>&1 && echo ok || echo fail", stage3_url);
        char *check_out = NULL;
        int check_rc = run_cmd_capture(check_cmd, &check_out);
        int is_ok = (check_rc == 0 && check_out && strstr(check_out, "ok"));
        free(check_out);
        if (!is_ok) {
            printf(COLOR_YELLOW "[!] Fallback not reachable, trying alt\n" COLOR_RESET);
            const char *alt_fetch =
                "curl -fsSL https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/ 2>/dev/null "
                "| grep -oE 'stage3-amd64-openrc-[0-9TZ]+\\.tar\\.xz' | head -n1";
            char *alt_file = NULL;
            if (run_cmd_capture(alt_fetch, &alt_file) == 0 && alt_file && *alt_file) {
                char *nl = strchr(alt_file, '\n'); if (nl) *nl='\0';
                if (strstr(alt_file, ".tar.xz")) {
                    xsnprintf(stage3_url, sizeof(stage3_url),
                              "https://distfiles.gentoo.org/releases/amd64/autobuilds/current-stage3-amd64-openrc/%s", alt_file);
                    printf(COLOR_GREEN "[+] Alternative stage3: %s\n" COLOR_RESET, stage3_url);
                }
            }
            free(alt_file);
        }
    }

    char tarball[512];
    xsnprintf(tarball, sizeof(tarball), "/tmp/gentoo-stage3-%ld.tar.xz", (long)getpid());
    printf(COLOR_BLUE ">>> Downloading stage3 (this may take a while)...\n" COLOR_RESET);
    xsnprintf(cmd, sizeof(cmd), "curl -fL -o '%s' '%s' || wget -O '%s' '%s'", tarball, stage3_url, tarball, stage3_url);
    if (run_cmd(cmd) != 0) {
        fprintf(stderr, COLOR_RED "[-] Failed to download stage3 from %s\n" COLOR_RESET, stage3_url);
        fprintf(stderr, COLOR_YELLOW "    Try manually: curl -o %s %s\n" COLOR_RESET, tarball, stage3_url);
        return 0;
    }

    printf(COLOR_BLUE ">>> Extracting stage3 to %s...\n" COLOR_RESET, path);
    xsnprintf(cmd, sizeof(cmd), "%star -xpf '%s' -C '%s' --xattrs-include='*.*' --numeric-owner 2>&1 | head -n 20", priv_prefix(), tarball, path);
    rc = run_cmd(cmd);
    xsnprintf(cmd, sizeof(cmd), "rm -f '%s'", tarball);
    run_cmd_quiet(cmd);

    if (rc != 0) {
        fprintf(stderr, COLOR_RED "[-] Failed to extract stage3\n" COLOR_RESET);
        return 0;
    }

    printf(COLOR_BLUE ">>> Setting up chroot basics...\n" COLOR_RESET);
    xsnprintf(cmd, sizeof(cmd),
             "%smkdir -p '%s/proc' '%s/sys' '%s/dev' '%s/tmp' '%s/run' '%s/%s' '%s/%s' '%s/var/db/repos/gentoo' && "
             "%scp -L /etc/resolv.conf '%s/etc/resolv.conf' 2>/dev/null; "
             "%schown -R '%s' '%s' 2>/dev/null; true",
             priv_prefix(), path, path, path, path, path, path, BUILD_DIR, path, BACKUP_DIR, path,
             priv_prefix(), path,
             priv_prefix(), build_user() ? build_user() : "root", path);
    run_cmd(cmd);

    printf(COLOR_BLUE ">>> Fixing Portage profile and repos...\n" COLOR_RESET);
    xsnprintf(cmd, sizeof(cmd),
        "%s"
        "chroot '%s' /bin/bash -c '"
        "eselect profile list 2>/dev/null | head -n5; "
        "if [ ! -e /etc/portage/make.profile ] || [ ! -L /etc/portage/make.profile ]; then "
        "  echo \">>> Fixing make.profile symlink...\"; "
        "  rm -rf /etc/portage/make.profile; "
        "  if [ -d /var/db/repos/gentoo/profiles/default/linux/amd64/23.0 ]; then "
        "    ln -sf /var/db/repos/gentoo/profiles/default/linux/amd64/23.0 /etc/portage/make.profile; "
        "  elif [ -d /var/db/repos/gentoo/profiles/default/linux/amd64/23.0/no-multilib ]; then "
        "    ln -sf /var/db/repos/gentoo/profiles/default/linux/amd64/23.0/no-multilib /etc/portage/make.profile; "
        "  else "
        "    prof=$(ls -d /var/db/repos/gentoo/profiles/default/linux/amd64/* 2>/dev/null | head -n1); "
        "    if [ -n \"$prof\" ]; then ln -sf $prof /etc/portage/make.profile; fi; "
        "  fi; "
        "fi; "
        "ls -l /etc/portage/make.profile 2>/dev/null; true' 2>&1 | head -n 20",
        priv_prefix(), path);
    run_cmd(cmd);

    printf(COLOR_BLUE ">>> Syncing Gentoo repos inside chroot (emerge-webrsync fallback)...\n" COLOR_RESET);
    xsnprintf(cmd, sizeof(cmd),
        "%s"
        "mount -t proc proc '%s/proc' 2>/dev/null; "
        "mount --rbind /sys '%s/sys' 2>/dev/null; mount --make-rslave '%s/sys' 2>/dev/null; "
        "mount --rbind /dev '%s/dev' 2>/dev/null; mount --make-rslave '%s/dev' 2>/dev/null; "
        "chroot '%s' /bin/bash -c '"
        "source /etc/profile; "
        "mkdir -p /var/db/repos/gentoo; "
        "if [ ! -d /var/db/repos/gentoo/profiles ]; then "
        "  echo \">>> Running emerge-webrsync (first sync)...\"; "
        "  emerge-webrsync 2>&1 | tail -n 30; "
        "else "
        "  echo \">>> Repo exists, running emerge --sync...\"; "
        "  emerge --sync 2>&1 | tail -n 30; "
        "fi; "
        "eselect profile list 2>/dev/null | head -n 20; "
        "if [ ! -L /etc/portage/make.profile ]; then "
        "  eselect profile set 1 2>/dev/null || eselect profile set default/linux/amd64/23.0 2>/dev/null || true; "
        "fi; "
        "'; "
        "umount -l '%s/proc' 2>/dev/null; "
        "umount -l '%s/sys' 2>/dev/null; "
        "umount -l '%s/dev' 2>/dev/null; true",
        priv_prefix(),
        path,
        path, path,
        path, path,
        path,
        path,
        path,
        path);
    run_cmd(cmd);

    if (!gentoo_chroot_exists(path)) {
        fprintf(stderr, COLOR_YELLOW "[!] Chroot init finished but gentoo-release not found, may still work\n" COLOR_RESET);
    }

    printf(COLOR_GREEN "[+] Gentoo chroot initialized at %s\n" COLOR_RESET, path);
    printf(COLOR_YELLOW "[!] If repo still fails, run manually: sudo chroot %s emerge --sync\n" COLOR_RESET, path);
    return 1;
}

int gentoo_chroot_mount(const char *path) {
    if (!path) return 0;
    printf(COLOR_BLUE ">>> Mounting chroot...\n" COLOR_RESET);
    char cmd[4096];
    xsnprintf(g_chroot_path_store, sizeof(g_chroot_path_store), "%s", path);

    xsnprintf(cmd, sizeof(cmd),
        "%s"
        "mount -t proc proc '%s/proc' 2>/dev/null; "
        "mount --rbind /sys '%s/sys' 2>/dev/null; mount --make-rslave '%s/sys' 2>/dev/null; "
        "mount --rbind /dev '%s/dev' 2>/dev/null; mount --make-rslave '%s/dev' 2>/dev/null; "
        "mount --rbind /run '%s/run' 2>/dev/null; mount --make-rslave '%s/run' 2>/dev/null; "
        "mount -t tmpfs tmpfs '%s/tmp' 2>/dev/null; "
        "mkdir -p '%s/%s' '%s/%s' '%s/%s' 2>/dev/null; "
        "mount --bind '%s' '%s/%s' 2>/dev/null; "
        "mount --bind '%s' '%s/%s' 2>/dev/null; "
        "mkdir -p '%s/%s' && touch '%s/%s' && mount --bind '%s' '%s/%s' 2>/dev/null; true",
        priv_prefix(),
        path,
        path, path,
        path, path,
        path, path,
        path,
        path, BUILD_DIR, path, BACKUP_DIR, path, EMERGE_DIR,
        BUILD_DIR, path, BUILD_DIR,
        BACKUP_DIR, path, BACKUP_DIR,
        path, WORLD_FILE, path, WORLD_FILE, WORLD_FILE, path, WORLD_FILE
    );
    int rc = run_cmd(cmd);
    if (rc != 0) {
        fprintf(stderr, COLOR_YELLOW "[!] Some mounts failed (maybe already mounted or no permission), continuing\n" COLOR_RESET);
    }
    return 1;
}

int gentoo_chroot_unmount(const char *path) {
    if (!path) return 0;
    if (!path[0]) {
        if (g_chroot_path_store[0]) path = g_chroot_path_store;
        else return 0;
    }
    printf(COLOR_BLUE ">>> Unmounting...\n" COLOR_RESET);
    char cmd[4096];
    xsnprintf(cmd, sizeof(cmd),
        "%s"
        "umount -l '%s/%s' 2>/dev/null; "
        "umount -l '%s/%s' 2>/dev/null; "
        "umount -l '%s/%s' 2>/dev/null; "
        "umount -l '%s/tmp' 2>/dev/null; "
        "umount -l '%s/run' 2>/dev/null; "
        "umount -l '%s/dev' 2>/dev/null; "
        "umount -l '%s/sys' 2>/dev/null; "
        "umount -l '%s/proc' 2>/dev/null; true",
        priv_prefix(),
        path, WORLD_FILE,
        path, BACKUP_DIR,
        path, BUILD_DIR,
        path,
        path,
        path,
        path,
        path
    );
    run_cmd(cmd);
    xsnprintf(cmd, sizeof(cmd),
        "%s"
        "grep '%s' /proc/mounts | cut -d' ' -f2 | sort -r | xargs -r umount -l 2>/dev/null; true",
        priv_prefix(), path);
    run_cmd(cmd);
    printf(COLOR_GREEN "[+] Unmounted\n" COLOR_RESET);
    return 1;
}

int gentoo_chroot_run_portage(const char *chroot_path, const char *pkg, int jobs) {
    if (!chroot_path || !pkg) return 1;
    printf(COLOR_GREEN ">>> Emerging (1 of 1) %s::gentoo\n" COLOR_RESET, pkg);
    printf(COLOR_BLUE ">>> Jobs: %d  Chroot: %s\n" COLOR_RESET, jobs, chroot_path);

    arm_chroot_signals();
    g_chroot_interrupted = 0;

    char cmd[4096];
    char repair_cmd[4096];
    xsnprintf(repair_cmd, sizeof(repair_cmd),
        "%s"
        "if [ ! -d '%s/var/db/repos/gentoo/profiles' ]; then "
        "  echo '>>> Repo missing, syncing...'; "
        "  mount -t proc proc '%s/proc' 2>/dev/null; "
        "  mount --rbind /sys '%s/sys' 2>/dev/null; mount --make-rslave '%s/sys' 2>/dev/null; "
        "  mount --rbind /dev '%s/dev' 2>/dev/null; mount --make-rslave '%s/dev' 2>/dev/null; "
        "  chroot '%s' /bin/bash -c 'source /etc/profile; emerge-webrsync 2>&1 | tail -n 20'; "
        "  umount -l '%s/proc' 2>/dev/null; umount -l '%s/sys' 2>/dev/null; umount -l '%s/dev' 2>/dev/null; "
        "fi; true",
        priv_prefix(),
        chroot_path,
        chroot_path,
        chroot_path, chroot_path,
        chroot_path, chroot_path,
        chroot_path,
        chroot_path, chroot_path, chroot_path);
    run_cmd(repair_cmd);

    xsnprintf(cmd, sizeof(cmd),
        "chroot '%s' /bin/bash -c \""
        "source /etc/profile; "
        "if [ ! -L /etc/portage/make.profile ]; then eselect profile set 1 2>/dev/null || true; fi; "
        "emerge --ask n --jobs=%d --load-average=%d '%s' 2>&1"
        "\"",
        chroot_path, jobs, jobs, pkg);

    int rc = run_cmd(cmd);

    if (g_chroot_interrupted) {
        printf(COLOR_RED "\n[!] Interrupted (Ctrl+C) - cleaning up chroot mounts...\n" COLOR_RESET);
        gentoo_chroot_unmount(chroot_path);
        return 130;
    }

    if (rc != 0) {
        fprintf(stderr, COLOR_RED "[-] Portage inside chroot failed (exit %d)\n" COLOR_RESET, rc);
        return rc;
    }

    printf(COLOR_GREEN "[+] Portage inside chroot finished successfully\n" COLOR_RESET);
    return 0;
}

/* ── Imitatie-merge: haal de artefacten die Portage in de chroot bouwde naar
   de host terug. Portage's eigen CONTENTS-manifest in /var/db/pkg bepaalt
   wat er bestaat; wij kopieren enkel de /usr-boom naar /usr/local (nooit /etc,
   nooit /var/db: imitatie mag een draaiende host nooit breken) en schrijven
   een omgekeerd manifest zodat `emerge -C` netjes kan opruimen. ─────────── */

static void chroot_manifest_path(char *out, size_t n, const char *pkg) {
    xsnprintf(out, n, "%s/chroot-world/%s", EMERGE_DIR, pkg);
}

int gentoo_chroot_manifest_exists(const char *pkg) {
    if (!pkg || !valid_pkgname(pkg)) return 0;
    char p[640];
    chroot_manifest_path(p, sizeof(p), pkg);
    return file_exists(p);
}

static int chroot_map_path(const char *in, char *out, size_t n) {
    if (strncmp(in, "/usr/", 5) != 0)
        return 0;
    xsnprintf(out, n, "/usr/local%s", in + 4);
    return 1;
}

int gentoo_chroot_install_artifacts(const char *chroot_path, const char *pkg) {
    char cmd[1024];
    xsnprintf(cmd, sizeof(cmd),
        "ls -1d '%s'/var/db/pkg/*/'%s'-[0-9]* 2>/dev/null | sort -V | tail -n1",
        chroot_path, pkg);
    char *cpv = NULL;
    if (run_cmd_capture(cmd, &cpv) != 0 || !cpv || !*cpv) {
        free(cpv);
        fprintf(stderr, COLOR_YELLOW
                "[!] No merged package found in the chroot database for '%s'; "
                "nothing was installed on the host.\n" COLOR_RESET, pkg);
        return 0;
    }
    size_t l = strlen(cpv);
    while (l && (cpv[l-1] == '\n' || cpv[l-1] == '\r')) cpv[--l] = '\0';

    char contents[1400];
    xsnprintf(contents, sizeof(contents), "%s/CONTENTS", cpv);
    FILE *f = fopen(contents, "r");
    if (!f) {
        fprintf(stderr, COLOR_RED "[-] Chroot package %s has no CONTENTS manifest\n" COLOR_RESET, cpv);
        free(cpv);
        return 0;
    }

    char world_dir[640], script[640], manpath[640], manTmp[648];
    xsnprintf(world_dir, sizeof(world_dir), "%s/chroot-world", EMERGE_DIR);
    xsnprintf(manpath, sizeof(manpath), "%s", world_dir); /* dir; file path below */
    chroot_manifest_path(manpath, sizeof(manpath), pkg);
    xsnprintf(manTmp, sizeof(manTmp), "%s.tmp.%ld", manpath, (long)getpid());
    xsnprintf(script, sizeof(script), "%s/.chroot-merge-%ld.sh", EMERGE_DIR, (long)getpid());

    char mkdir_cmd[768];
    xsnprintf(mkdir_cmd, sizeof(mkdir_cmd), "%smkdir -p '%s'", priv_prefix(), world_dir);
    run_cmd(mkdir_cmd);

    FILE *sc = fopen(script, "w");
    FILE *man = fopen(manTmp, "w");
    if (!sc || !man) {
        if (sc) fclose(sc);
        if (man) fclose(man);
        fclose(f); free(cpv);
        fprintf(stderr, COLOR_RED "[-] Cannot write chroot merge script\n" COLOR_RESET);
        return 0;
    }

    char line[1024];
    int copied = 0, linked = 0, dirs = 0, skipped = 0;
    while (fgets(line, sizeof(line), f)) {
        char path[1024];
        int type = -1; /* 0 obj, 1 sym, 2 dir */
        char symtgt[512]; symtgt[0] = '\0';
        if (strncmp(line, "obj ", 4) == 0) {
            type = 0;
            if (sscanf(line + 4, "%1023s", path) != 1) continue;
        } else if (strncmp(line, "dir ", 4) == 0) {
            type = 2;
            if (sscanf(line + 4, "%1023s", path) != 1) continue;
        } else if (strncmp(line, "sym ", 4) == 0) {
            type = 1;
            char *dash = strstr(line + 4, "->");
            if (!dash) continue;
            size_t plen = (size_t)(dash - (line + 4));
            while (plen && line[4 + plen - 1] == ' ') plen--;
            if (plen >= sizeof(path)) continue;
            memcpy(path, line + 4, plen);
            path[plen] = '\0';
            char *t = dash + 2;
            while (*t == ' ') t++;
            size_t tl = 0;
            while (t[tl] && t[tl] != ' ' && t[tl] != '\n' && tl + 1 < sizeof(symtgt)) {
                symtgt[tl] = t[tl]; tl++;
            }
            symtgt[tl] = '\0';
        } else continue;
        if (path[0] != '/') continue;

        char dst[1152];
        if (!chroot_map_path(path, dst, sizeof(dst))) { skipped++; continue; }

        char qsrc[2600], qdst[2400], qpar[2400], qtgt[2600];
        char srcfull[1300];
        xsnprintf(srcfull, sizeof(srcfull), "%s%s", chroot_path, path);
        if (!shell_quote(srcfull, qsrc, sizeof(qsrc)) || !shell_quote(dst, qdst, sizeof(qdst)))
            continue;
        char parent[1152];
        size_t dl = strlen(dst);
        while (dl && dst[dl-1] != '/') dl--;
        if (dl > 1) { xsnprintf(parent, sizeof(parent), "%.*s", (int)dl, dst); }
        else xsnprintf(parent, sizeof(parent), "/");
        if (!shell_quote(parent, qpar, sizeof(qpar))) continue;

        if (type == 0) {
            fprintf(sc, "install -d %s && cp -a %s %s\n", qpar, qsrc, qdst);
            fprintf(man, "obj %s\n", dst);
            copied++;
        } else if (type == 1) {
            if (!shell_quote(symtgt, qtgt, sizeof(qtgt))) continue;
            fprintf(sc, "install -d %s && ln -sfn %s %s\n", qpar, qtgt, qdst);
            fprintf(man, "sym %s\n", dst);
            linked++;
        } else {
            fprintf(sc, "install -d %s\n", qdst);
            fprintf(man, "dir %s\n", dst);
            dirs++;
        }
    }
    fclose(f);
    fclose(sc);
    fclose(man);
    free(cpv);

    char runc[1400];
    char qscript[1600];
    if (!shell_quote(script, qscript, sizeof(qscript))) { unlink(manTmp); unlink(script); return 0; }
    xsnprintf(runc, sizeof(runc), "%ssh %s", priv_prefix(), qscript);
    int rc = run_cmd(runc);
    unlink(script);
    if (rc != 0) {
        fprintf(stderr, COLOR_RED "[-] Imitation merge failed (exit %d); manifest discarded\n" COLOR_RESET, rc);
        unlink(manTmp);
        return 0;
    }
    unlink(manpath);
    if (rename(manTmp, manpath) != 0)
        fprintf(stderr, COLOR_YELLOW "[!] Could not register manifest %s\n" COLOR_RESET, manpath);
    printf(COLOR_GREEN "[+] Imitation merge: %d file(s), %d link(s), %d dir(s) installed under /usr/local "
           "(%d chroot-only entries skipped)\n" COLOR_RESET, copied, linked, dirs, skipped);
    add_to_world(pkg);
    return 1;
}

int gentoo_chroot_unmerge(const char *pkg) {
    if (!pkg || !valid_pkgname(pkg)) return 0;
    char manpath[640];
    chroot_manifest_path(manpath, sizeof(manpath), pkg);
    FILE *f = fopen(manpath, "r");
    if (!f) return 0;
    char script[640];
    xsnprintf(script, sizeof(script), "%s/.chroot-unmerge-%ld.sh", EMERGE_DIR, (long)getpid());
    FILE *sc = fopen(script, "w");
    if (!sc) { fclose(f); return 0; }
    char line[1152];
    int removed = 0;
    while (fgets(line, sizeof(line), f)) {
        char type[8], dst[1100];
        if (sscanf(line, "%7s %1100[^\n]", type, dst) != 2) continue;
        size_t dl = strlen(dst);
        while (dl && (dst[dl-1] == '\n' || dst[dl-1] == '\r')) dst[--dl] = '\0';
        if (strncmp(dst, "/usr/local", 10) != 0 || dl < 12) continue; /* veiligheid: alleen onze prefix */
        char qdst[2600];
        if (!shell_quote(dst, qdst, sizeof(qdst))) continue;
        if (type[0] == 'd')
            fprintf(sc, "rmdir --ignore-fail-on-non-empty -p %s 2>/dev/null; true\n", qdst);
        else
            fprintf(sc, "rm -f %s\n", qdst);
        removed++;
    }
    fclose(f);
    fclose(sc);
    char runc[1400], qscript[1600];
    if (!shell_quote(script, qscript, sizeof(qscript))) { unlink(script); return 0; }
    xsnprintf(runc, sizeof(runc), "%ssh %s", priv_prefix(), qscript);
    int rc = run_cmd(runc);
    unlink(script);
    if (rc != 0) {
        fprintf(stderr, COLOR_RED "[-] Chroot manifest removal failed (exit %d)\n" COLOR_RESET, rc);
        return 0;
    }
    char rmman[768];
    xsnprintf(rmman, sizeof(rmman), "%srm -f '%s'", priv_prefix(), manpath);
    run_cmd(rmman);
    printf(COLOR_GREEN "[+] Removed %d manifest entr(ies) from /usr/local\n" COLOR_RESET, removed);
    return 1;
}

int cmd_gentoo_imitation_build(const char *pkg) {
    if (!valid_pkgname(pkg)) {
        fprintf(stderr, COLOR_RED "[-] Invalid package name: '%s'\n" COLOR_RESET, pkg);
        return 0;
    }

    const char *chroot_path = get_gentoo_chroot_path();
    if (!chroot_path || !*chroot_path) {
        chroot_path = GENTOO_CHROOT_DIR;
    }

    printf(COLOR_GREEN ">>> Emerging %s\n" COLOR_RESET, pkg);

    if (!gentoo_chroot_init(chroot_path)) {
        fprintf(stderr, COLOR_RED "[-] Failed to init Gentoo chroot\n" COLOR_RESET);
        return 0;
    }

    if (!gentoo_chroot_mount(chroot_path)) {
        fprintf(stderr, COLOR_RED "[-] Failed to mount chroot\n" COLOR_RESET);
        return 0;
    }

    int portage_rc = gentoo_chroot_run_portage(chroot_path, pkg, (int)get_jobs());

    if (portage_rc == 0 && !gentoo_chroot_install_artifacts(chroot_path, pkg))
        portage_rc = 1;   /* geen artefacten -> via het normale pad als falen rapporteren */

    gentoo_chroot_unmount(chroot_path);

    if (portage_rc != 0) {
        if (portage_rc == 130) {
            printf(COLOR_YELLOW "[!] Build interrupted, chroot cleaned up\n" COLOR_RESET);
        } else {
            fprintf(stderr, COLOR_RED "[-] Imitation build failed\n" COLOR_RESET);
            fprintf(stderr, COLOR_YELLOW "    Tip: try manual fix: sudo chroot %s emerge --sync && sudo chroot %s eselect profile set 1\n" COLOR_RESET, chroot_path, chroot_path);
        }
        return 0;
    }

    printf(COLOR_GREEN "\n>>> Completed %s\n" COLOR_RESET, pkg);
    return 1;
}
