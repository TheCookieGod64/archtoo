# archtoo

Archtoo is a lightweight, Gentoo-style package compilation engine written in C for Arch Linux. It bridges the gap between binary package management and source-based hardware optimization by automating source fetching, `makepkg` compilation, and package locking in `/etc/pacman.conf`.

## Features

- Hardware-Native Compilation: Automatically exports `-march=native -O3 -pipe` and multi-threaded `MAKEFLAGS` during build execution.
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

To remove the installed binary:

```bash
sudo make uninstall
```

## Usage

### Build and Install a Package
Fetches source code, offers optional PKGBUILD editing, compiles with native flags, installs, and locks the package:

```bash
emerge <package_name>
```

Examples:
```bash
emerge htop
emerge linux-zen
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

## System Paths

- Executable Binary: `/usr/local/bin/emerge`
- World Tracking File: `/usr/local/emerge/world`
- Central Build Directory: `/usr/local/emerge/builds/`

## License

See the `LICENSE` file in this repository for details.