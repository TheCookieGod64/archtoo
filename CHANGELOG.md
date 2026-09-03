# Changelog

## v1.5.0

### Added

- **Non-interactive pacman by default.** `pacman -Syu`, `pacman -U`, dependency
  installation, and unmerge operations now receive `--noconfirm`. Use `-i` or
  `--interactive` to restore pacman's confirmation prompts.
- **Timed Archtoo prompts.** Questions such as PKGBUILD editing automatically
  choose their displayed default after 300 seconds. Override per invocation
  with `--prompt-timeout SEC`; zero waits forever.
- **User configuration.** `~/.config/archtoo/config` supports
  `pacman_confirm=true|false` and `prompt_timeout=0..86400`. CLI options take
  precedence over the file.

## v1.4.4

### Fixed

- **No second sudo prompt after a long build.** v1.4.3 refreshed sudo from a
  helper process, but systems using sudo's `timestamp_type=ppid` gave the
  later `makepkg`/`pacman -U` process a different credential scope. That made
  package installation request a second password from non-interactive input
  and fail. Archtoo now asks once and re-executes itself as root, while still
  dropping source fetching and compilation back to `SUDO_USER`. Makepkg no
  longer installs through its own nested `sudo`; after compilation Archtoo's
  root process installs all generated split-package archives in one
  `pacman -U` transaction. Configuration edits and kernel hooks likewise run
  directly as root, so no later password prompt is possible.

## v1.4.3

### Changed

- **One sudo prompt per invocation.** A plain `emerge` now invalidates any
  cached sudo timestamp and authenticates immediately, so it always asks for
  the sudo password exactly once. A small credential keeper refreshes that
  timestamp during long builds, preventing later `pacman -Syu`, package
  installation, `pacman.conf`, and kernel-hook steps from prompting again.
  Help and version output remain unprivileged.

## v1.4.2

### Fixed

- **Last unguarded `fopen()` removed.** `cmd_world_update()` still opened the
  world file with plain `fopen()`; under `sudo` that read runs as root inside
  the user-owned `EMERGE_DIR`, so it now goes through `fopen_nofollow()` like
  every other access to that tree.

- **`run_cmd_quiet()` wrapper buffer enlarged.** Since v1.4.1 `xsnprintf()`
  makes truncation fatal, and the 2048-byte wrapper buffer was exactly the
  size of the largest command a caller builds (`lock_pacman_pkg()`'s sed
  pipeline). A long `--config`/`pacman.conf` path could therefore turn a
  valid command into a hard exit instead of running it. The buffer is now
  4608 bytes.

## v1.4.1

### Fixed

- **Kernel detection no longer trusts the package name alone.** The old
  heuristic happily treated `linux-wifi-hotspot`, `linux-atm`,
  `linux-firmware-whence` (and even `linuxcnc`) as kernels, regenerating the
  initramfs on every build and writing a bogus `-headers` line into
  `pacman.conf`. The name check is now strict (`linux` or `linux-<variant>`,
  with known non-kernel families/suffixes rejected), and the hooks are gated
  on a content check: a kernel is only a kernel if a built archive actually
  contains `usr/lib/modules/*/vmlinuz`.

- **Symlink attack in the sudo build path closed.** The step script was
  created with `fopen(..., "w")` at a predictable PID-only name inside
  `EMERGE_DIR`, which is deliberately owned by the unprivileged build user;
  a hostile process running as that user could pre-plant a symlink and make
  root truncate an arbitrary file. The script is now created with
  `O_CREAT|O_EXCL|O_NOFOLLOW` (atomic, never follows a symlink) under an
  unpredictable random name. The same protection is applied to the other
  root writes into `EMERGE_DIR`: the world file and `makepkg.archtoo.conf`
  are opened through a `fopen_nofollow()` helper.

- **`-jN` / `--jobs=N` joined forms now validate 1-1024 like `-j N` and
  `--jobs N`.** `-j999999999` used to sail straight through into
  `MAKEFLAGS`; `-j0` and trailing garbage (e.g. `-j4x`) are rejected too.

- **Only the first active `IgnorePkg` line is appended to.** The lock
  `sed` matched every active line (the commented-line branch already used the
  GNU `0,/re/` first-match idiom; the active-line branch did not), so two
  `IgnorePkg` lines in `pacman.conf` grew a duplicate entry on every build
  cycle.

- **Command truncation is now fatal instead of silent.** A tiny `xsnprintf()`
  (buffer too small -> print error, exit) replaced `snprintf()` across the
  codebase. The systemd-inhibit wrapper in particular could truncate a long
  `--config` path and quietly run a different command than intended.

## v1.4.0

### Added

- **`emerge -D <package>` / `--deselect`** stops managing a package without
  uninstalling it: the `IgnorePkg` lock is removed and the entry is dropped
  from the world set, but the package stays installed and pacman takes over
  again. This is Gentoo's `emerge --deselect`. Previously the only way to
  hand a package back was a full unmerge, which is impossible for anything
  other packages depend on -- `pacman -Rns ffmpeg` simply refuses -- leaving
  no way out but editing `pacman.conf` and the world file by hand. Kernels
  also have their `-headers` companion unlocked.

- **`emerge -U` now runs `pacman -Syu` before rebuilding the world set.**
  The order is deliberate: world packages are held in `IgnorePkg`, so pacman
  skips them and cannot produce a partial upgrade, and the source rebuilds
  then link against the freshly updated libraries. If the upgrade fails the
  world rebuild is abandoned rather than run on top of a half-updated
  system. Skip with `--no-sync`.

### Fixed

- **A broken `systemd-inhibit` could kill the build.** v1.3.0 only checked
  that the binary existed, but it is present and non-functional in
  containers, in some SSH sessions and under restrictive polkit, where it
  exits with "Access denied". Wrapping makepkg in a command that fails meant
  the compile never started. It is now probed with a no-op first, and the
  build proceeds without inhibition if it is unusable.

## v1.3.0

## v1.3.0

### Added

- **Missing PGP signing keys are imported automatically.** PKGBUILDs that
  verify upstream signatures list their keys in `validpgpkeys`; if those are
  not in your keyring makepkg stops with "One or more PGP signatures could not
  be verified", which is the single most common way an otherwise-fine AUR
  build fails. Archtoo now reads the array, skips keys you already have, and
  fetches the rest from `keyserver.ubuntu.com`, falling back to
  `keys.openpgp.org`. Both 40- and 16-character key IDs are handled, in
  single- and multi-line arrays. The array is parsed with awk rather than by
  sourcing the PKGBUILD, so nothing from it executes at that point. Disable
  with `--no-keys`.

- **The machine no longer suspends mid-build.** The compile is wrapped in
  `systemd-inhibit --what=sleep:idle:handle-lid-switch`, held for exactly the
  duration of the build and released afterwards. Losing a multi-hour compile
  to idle suspend is otherwise very easy. Disable with `--no-inhibit`. If
  `systemd-inhibit` is unavailable, Archtoo warns and builds anyway.

### Fixed

- **Files created under `sudo` stayed owned by root**, which broke the next
  non-sudo run. `makepkg.archtoo.conf` and the rewritten world file were both
  created by root and never handed back, so after any `sudo emerge` a plain
  `emerge <pkg>` would fail with "Cannot write /usr/local/emerge/
  makepkg.archtoo.conf". Both are now chowned to the build user.
- The temporary script used to drop privileges had a fixed name, so two
  concurrent runs could overwrite each other's. It is now per-process.
- Tool detection used hardcoded `/usr/bin/...` paths, which missed binaries
  installed elsewhere. `systemd-inhibit`, `mkinitcpio`, `dracut`,
  `grub-mkconfig`, `bootctl` and `sbctl` are now looked up on `PATH`.

## v1.2.1

## v1.2.1

### Fixed

- **A nonexistent package appeared to fetch successfully.** The AUR git
  server returns an *empty repository* for any well-formed package name,
  including names that do not exist, so `git clone` exits 0 and creates a
  directory. `fetch_sources()` only checked that the directory existed, so a
  typo such as `emerge htpo` passed the fetch stage and failed later with a
  confusing `No PKGBUILD in ...` instead of "not found". The presence of a
  PKGBUILD is now what counts as success, for both the `pkgctl` and AUR
  paths, and the empty checkout the AUR handed over is removed rather than
  left behind to confuse the next run.

## v1.2.0

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
