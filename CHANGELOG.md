# Changelog

## v1.2.0

### Added

- **`-j` / `--jobs N`** sets the parallel build job count. Previously
  `MAKEFLAGS` was hardcoded to `-j$(nproc)` and could not be overridden, which
  is the wrong default on a memory-constrained machine: each parallel `rustc`
  or C++ translation unit can hold several gigabytes, and an LTO link is one
  very large single process. On a 4-core / 8 GB system, `-j2` is often the
  difference between a build that finishes and one that thrashes swap for
  hours. Accepts `-j2`, `-j 2`, `--jobs 2` and `--jobs=2`, validated to 1-1024.

- **`-r` / `--resume`** reuses the existing build tree instead of backing it
  up and re-cloning, and passes `-e` (`--noextract`) to makepkg so `$srcdir`
  is left alone and already-compiled object files are kept. Without this, an
  interrupted multi-hour build had to start from zero, because v1.1.0 always
  destroys and re-clones. The build directory is also never deleted after a
  `--resume` run. If no tree exists, it warns and starts fresh.

- When a build fails, the error now points at `emerge --resume <package>`.

## v1.1.0

## v1.1.0

### Changed

- **An existing build tree is now destroyed and rebuilt, not reused.**
  Previously `emerge firefox` found the old checkout, ran `git pull` and
  handed it to makepkg, which frequently just reinstalled the prebuilt
  package. Archtoo now moves the old tree to `/usr/local/emerge/backups/`,
  deletes it, and clones fresh, so the package is genuinely recompiled every
  time.
- **The backup is restored automatically if anything goes wrong.** A failed
  clone, a failed compile, or Ctrl-C puts the previous build tree back exactly
  where it was. On success the backup is discarded. `SIGINT`, `SIGTERM` and
  `SIGHUP` are handled, and the handler only uses async-signal-safe calls.
- **`sudo emerge <package>` is now supported, Gentoo-style.** Because makepkg
  refuses to run as root, Archtoo drops back to `SUDO_USER` for fetching and
  compiling, the same way Portage drops to the `portage` user, while pacman,
  the `pacman.conf` edits and the kernel hooks run with the privileges they
  need. Running without sudo still works and calls sudo per-operation as
  before. A bare root login is rejected, since there is no unprivileged user
  to build as.

## v1.0.2

## v1.0.2

### Fixed

- **`makepkg` reinstalled stale packages instead of rebuilding.** Without
  `-f`, `makepkg` finds a leftover `.pkg.tar.zst` in the build directory and
  installs that rather than compiling ("Er werd al een pakket gebouwd..."). A
  package was therefore never rebuilt with the native flags once an artifact
  existed, and `emerge -U` reinstalled the whole world set without compiling
  anything. Now uses `makepkg -sif`.
- **Unmerge left `<pkg>-debug` orphaned.** When `makepkg.conf` has the `debug`
  option enabled, building produces a companion debug package which is not a
  dependency, so `pacman -Rns <pkg>` did not remove it. It is now detected and
  removed alongside the main package.
- Build steps are numbered `[1/4]`..`[4/4]` for ordinary packages instead of
  skipping from 2 to 4 where the kernel-hook step would have been.

## v1.0.1

Bugfix release. Three of these caused silent misbehaviour: builds were not
actually optimised, packages were not actually locked, and unmerging could
corrupt `/etc/pacman.conf`. Upgrading is recommended for all users.

### Fixed — critical

- **Native compilation had no effect.** `set_build_env()` exported `CFLAGS`,
  `CXXFLAGS` and `MAKEFLAGS`, but `makepkg` sources `/etc/makepkg.conf`, which
  assigns those variables unconditionally and discards the environment. Every
  package was compiled with the stock `-march=x86-64 -O2`. Archtoo now
  generates `/usr/local/emerge/makepkg.archtoo.conf`, which sources the system
  config and then overrides the flags, and passes it via `makepkg --config`.
  `KCFLAGS`/`KCPPFLAGS` remain environment variables, since kernel PKGBUILDs
  do read those.

- **Package locking silently failed on an unmodified `pacman.conf`.** Arch
  ships the template line padded as `#IgnorePkg   =`. The `grep '^#IgnorePkg'`
  branch matched it, but the `sed 's/^#IgnorePkg =/'` inside required exactly
  one space and never fired — so nothing was written while the tool reported
  `[+] locked in pacman.conf`. `pacman -Syu` was free to overwrite custom
  builds. The edit now tolerates arbitrary whitespace, ignores commented
  lines when testing whether a package is already locked, and verifies the
  result instead of assuming success.

- **Unmerging corrupted `pacman.conf`.** Removal used `\<pkg\>`, and `-` is a
  word boundary, so `emerge -C linux` rewrote
  `IgnorePkg = linux-zen linux-headers` into `IgnorePkg = -zen -headers`.
  Removal now matches whole space-delimited tokens, and package names are
  escaped before being used as regexes (`gtk+`, `lib.foo` were also affected).

- **Shell injection through package names.** Names were interpolated straight
  into `system()` calls, several of them `sudo`. `emerge 'x; rm -rf /'` ran.
  Because `-U` replays the world file through the same path, a single crafted
  line gave persistent code execution. All names are now validated against
  the legal Arch package charset before reaching a shell, both from `argv`
  and from the world file.

### Fixed — behaviour

- Unmerging a kernel now also unlocks its `<pkg>-headers` entry, which was
  locked at build time and previously left in `IgnorePkg` permanently.
- `-U` reads the world list into memory before building. It was iterating an
  open handle on a file that `cmd_build()` appends to and rewrites, which
  skipped or repeated packages.
- `-U` reports per-package results and lists what failed, instead of printing
  `WORLD UPDATE COMPLETED (n packages)` when every build had failed.
- `cmd_build`, `cmd_unmerge` and `cmd_world_update` return a status and `main`
  propagates it. Failed fetches, failed compiles and unknown packages no
  longer exit `0`.
- `run_cmd()` returns the real exit code. It previously returned the raw
  `wait` status from `system()`, where exit code 3 arrives as 768.
- A user interrupt (Ctrl-C) during `makepkg` is distinguished from a build
  failure.
- `ask_yes_no()` takes an explicit default and returns it on EOF. It used to
  answer **yes** on EOF — including for the `rm -rf` cleanup prompt, which
  fired whenever stdin was not a terminal.
- `ask_yes_no()` drains over-long input, which previously spilled into the
  next prompt and answered it.
- `git pull` failures are no longer ignored. A dirty or unreachable checkout
  used to be rebuilt silently as if up to date; a leftover non-git directory
  from a failed clone is now detected and can be re-cloned.
- `pkgctl` errors are written to `builds/.archtoo-fetch.log` instead of being
  discarded, so a network failure is distinguishable from "not in the repos".
- Ownership of `/usr/local/emerge` is repaired on every run, not only when the
  directory is first created, and the world file is checked for writability.
  The invoking user is resolved via `SUDO_USER`/`getpwuid()` rather than the
  attacker-controllable `$USER`.
- The working directory is restored after a build, and the process steps out
  of the build directory before deleting it.

### Added

- `--noconfirm` for unattended runs; every prompt takes its safe default.
- Multiple packages per invocation: `emerge htop neovim ripgrep`.
- Refuses to run as root, with an explanation, instead of failing deep inside
  `makepkg`.
- `-h` / `--help`.
- Kernel detection covers `linux-rt`, `linux-xanmod`, `-git` variants and
  other prefixed kernels rather than four hardcoded names, while excluding
  `linux-firmware`, `linux-api-headers` and `*-headers`/`*-docs`.
- Kernel hooks support dracut, systemd-boot, rEFInd and Limine, warn when no
  bootloader is detected, report initramfs failures loudly, and note when
  `sbctl` is present and Secure Boot re-signing may be needed.
- `/etc/pacman.conf` is backed up to `/etc/pacman.conf.archtoo.bak` before the
  first modification.
- Paths in `headers/config.h` are overridable at compile time so the tool can
  be exercised against a scratch tree.

### Build system

- Header dependencies are tracked (`-MMD -MP`); editing a header rebuilds the
  objects that use it. Previously it did not, producing binaries linked from
  stale objects.
- `make check` compiles with `-Wpedantic -Werror` for CI. The tree is
  warning-free under `-Wall -Wextra -Wshadow -Wwrite-strings
  -Wformat-truncation=2`.
- `install`/`uninstall` no longer call `sudo` internally and honour `DESTDIR`
  and `PREFIX`, so packaging and CI work. Run `sudo make install` yourself.
- Fixed a target name collision between the `dist` directory rule and the
  `dist` phony target, which made `make` emit "overriding recipe" warnings.
- `-std=gnu11` is set explicitly; `src/utils.c` did not compile under a strict
  `-std=c11` because `setenv` needs `_POSIX_C_SOURCE`.
- Build messages are in English, matching the program output.

## v1.0.0

Initial release.
