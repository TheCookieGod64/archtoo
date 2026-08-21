# archtoo

Archtoo is a lightweight, Gentoo-style package compilation engine written in C for Arch Linux. It bridges the gap between binary package management and source-based hardware optimization by automating source fetching, `makepkg` compilation, and package locking in `/etc/pacman.conf`.

## Features

- Hardware-Native Compilation: Builds with `-march=native -O3 -pipe` and multi-threaded `MAKEFLAGS` via a generated makepkg config (environment variables alone are ignored by `makepkg`, which sources `/etc/makepkg.conf`).
- Dual Source Resolution: Clones official Arch Linux repositories via `pkgctl` with automatic fallback to the Arch User Repository (AUR).
- Pacman Protection: Locks built packages in `/etc/pacman.conf` under `IgnorePkg` to prevent `pacman -Syu` from overwriting custom binaries.
- World Set Management: Tracks all user-compiled packages in `/usr/local/emerge/world`.
- World Updates (`-U`): Rebuilds all tracked `@world` packages with a single command.
- Kernel Build Hooks: Automatically runs `mkinitcpio -P` and `grub-mkconfig` when building kernel targets (e.g., `linux-zen`).
- Clean Unmerge (`-C`): Removes packages via `pacman -Rns`, cleans world file entries, and removes pacman locks.

## Project Structure

```
archtoo/
├── bin/          # Output directory for the executable
├── build/        # Intermediate object files (.o)
├── headers/      # C header files (.h)
├── src/          # C source files (.c)
├── Makefile      # Build configuration
├── LICENSE       # GPL-3.0-or-later (operative)
├── LICENSE.CKL   # GPLv3 s7 additional terms + CKL-2.0 tradition
├── CHANGELOG.md
└── README.md
```

## Prerequisites

Ensure the required development utilities are installed:

```bash
sudo pacman -S --needed base-devel devtools git
```

## Building and Installation

Clone the repository, compile the C source code, and install the binary to `/usr/local/bin`:

```bash
git clone https://github.com/TheCookieGod64/archtoo.git
cd archtoo
make
sudo make install
```

`make check` runs a strict warning-free compile (`-Wpedantic -Werror`), and
`make dist` produces a portable `-march=x86-64` release archive. The default
`make` target uses `-march=native`, so do not copy `bin/emerge` to a different
machine — build it there instead.

To remove the installed binary:

```bash
sudo make uninstall
```

## Usage

### Build and Install a Package
Fetches source code, offers optional PKGBUILD editing, compiles with native flags, installs, and locks the package:

```bash
emerge <package_name>...
```

Examples:
```bash
emerge htop
emerge linux-zen
emerge htop neovim ripgrep      # several at once
```

### Unmerge a Package
Removes the package, unlocks it in `/etc/pacman.conf`, and removes its record from the world file:

```bash
emerge -C <package_name>
```

### Rebuild World Set
Rebuilds all packages listed in `/usr/local/emerge/world`:

```bash
emerge -U
```

### Display Version
```bash
emerge -v
```

### Non-interactive Mode
Skips every prompt and uses the safe default for each (build directories are
kept, the PKGBUILD editor is not opened):

```bash
emerge --noconfirm <package_name>
```

Archtoo must be run as your normal user, not as root — `makepkg` refuses to
build as root. It calls `sudo` itself where privileges are required.

All commands return a non-zero exit status on failure, so they can be used in
scripts.

## System Paths

- Executable Binary: `/usr/local/bin/emerge`
- World Tracking File: `/usr/local/emerge/world`
- Central Build Directory: `/usr/local/emerge/builds/`
- Generated makepkg config: `/usr/local/emerge/makepkg.archtoo.conf`
- `pacman.conf` backup (created before the first lock): `/etc/pacman.conf.archtoo.bak`

## License

Archtoo is licensed under the **GNU General Public License v3.0 or later**
(SPDX: `GPL-3.0-or-later`). The full text is in [`LICENSE`](LICENSE).

Additional attribution terms, granted under GPLv3 section 7, are in
[`LICENSE.CKL`](LICENSE.CKL) — which also preserves the original
TheCookieGod64 Public License (CKL-2.0) as the non-binding tradition it
deserves to be. The Shrek clause survives. It is just no longer a condition
of use, because GPLv3 section 7 does not permit adding restrictions on top
of the GPL.

If the two documents ever disagree, the GPL wins.