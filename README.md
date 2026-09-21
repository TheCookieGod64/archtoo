# archtoo (NASM Edition)

Archtoo is a lightweight, Gentoo-style package compilation engine written in C for Arch Linux. **This is v3.0.0: the full hand-written x86-64 NASM port of the entire engine.** Same program, same behaviour, same CLI - now 26k lines of pure assembly across 29 modules, SysV AMD64 ABI, zero compiler bloat.

## What changed in the port

- **Every `.c` module is now an `.asm` module** in `src/` (29 files). `main` tails into `archtoo_cli_main`, exactly as in v2.4.0.
- **Bloatware stripped:** no `.eh_frame` tables, no compiler padding comments, no GAS-isms - clean `global`/`extern`/`SECTION` blocks with tabs, like a human typed them (a human did, technically: at 3am, with a hex editor).
- **Byte-faithful:** instruction bytes per function are identical to the `-march=native -O3` GCC output (modulo alignment padding). All `.rodata`/`.data` blobs are byte-identical.
- **Version 3.0.0** is patched into the string table itself, not just the banners - `emerge --version` really says so.
- **`--binary` mode**: tries `sudo pacman -S --needed <pkg>` first - when the package is not in
  the repos it does a yay-style AUR hunt for prebuilt variants (`-bin` / `-binary` / `-prebuilt` / `-release`)
  over the AUR RPC, printing votes/popularity of what it finds. Manual repo download (URL -> curl -> self
  SHA256 -> `pacman -U`) remains as fallback when `-S` fails on a package that *is* in the repos.
- **`headers/archtoo.inc`** manifests all 137 public symbols plus version defines.
**Portable baseline built-in.** The released NASM is generated from `-march=x86-64 -mtune=generic` objects (your own `make dist` flags!) instead of `-march=native` of whoever happened to own the build box. Zero AVX/AVX-512 in the instruction stream: the binary now runs on any x86-64, no illegal-instruction surprises on non-AVX512 CPUs. Want a native-tuned build? Regenerate from the C edition with your own `-march=native`.

## Features (unchanged from the C edition)

- Hardware-Native Compilation: `-march=native -O3 -pipe` targets via generated makepkg config, `--target=` / `--opt-level=` overrides.
- Dual Source Resolution: `pkgctl` + AUR RPC fallback.
- Pacman Protection: `IgnorePkg` locking, `@world` tracking, `-U` world updates.
- Kernel Build Hooks, Clean Unmerge `-C`, binary download mode with self-SHA256.

## Project Structure

```
archtoo/
|-- bin/            # Output directory for the executable
|-- build/          # Intermediate object files (.o, from nasm)
|-- headers/
|   `-- archtoo.inc # Public symbol manifest + version defines
|-- src/            # 29 hand-written NASM modules (one per original .c)
|   |-- main.asm    # Entry point -> jmp archtoo_cli_main
|   `-- cli.asm     # Argument parsing, help/version output, dispatch
|-- Makefile        # nasm + ld build configuration
|-- LICENSE         # GPL-3.0-or-later (operative)
|-- LICENSE.CKL     # GPLv3 s7 additional terms + CKL-2.0 tradition
|-- CHANGELOG.md
`-- README.md
```

## Prerequisites

```bash
sudo pacman -S --needed nasm base-devel git
```

(`crt1.o`/`libc.so.6` paths are resolved through `gcc -print-file-name`, so a working `gcc` must be installed for linking.)

## Building and Installation

```bash
git clone git@github.com:TheCookieGod64/archtoo.git
cd archtoo
make
sudo make install
```

## Verification

```
make check      # builds and runs bin/emerge --version
```

The link step is a plain `ld` invocation with glibc CRT objects; the resulting
binary reproduces the C edition output byte-for-byte on `--version`, `-h`,
error paths and query commands.

## License

GPL-3.0-or-later. Copyright (C) 2026 TheCookieGod64.
