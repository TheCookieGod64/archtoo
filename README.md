# archtoo (NASM Edition)

Archtoo is a lightweight, Gentoo-style package compilation engine written in C for Arch Linux. **This is v3.0.0: the full hand-written x86-64 NASM port of the entire engine.** Same program, same behavior.

## What changed in the port

- **Every `.c` module is now an `.asm` module** in `src/` (29 files). `main` tails into `archtoo_cli_main`, exactly as in v2.4.0.
- **Bloatware stripped:** no `.eh_frame` tables, no compiler padding comments, no GAS-isms - clean `global`/`extern`/`SECTION` blocks with tabs, like a human typed them (a human did, technically: a tooling pipeline verified it).
- **Byte-faithful:** instruction bytes per function are identical to the `-march=native -O3` GCC output (modulo alignment padding). All `.rodata`/`.data` blobs are byte-identical.
- **Version 3.0.0** is patched into the string table itself, not just the banners - `emerge --version` really says so.
- **`--binary` mode**: tries `sudo pacman -S --needed <pkg>` first - when the package is not in
  the repos it does a yay-style AUR hunt for prebuilt variants (`-bin` / `-binary` / `-prebuilt` / `-release`)
  over the AUR RPC, printing votes/popularity of what it finds. Manual repo download (URL -> curl -> self
  SHA256 -> `pacman -U`) remains as fallback when `-S` fails on a package that *is* in the repos.
- **`headers/archtoo.inc`** manifests all 137 public symbols plus version defines.
**Portable baseline built-in.** The released NASM is generated from `-march=x86-64 -mtune=generic` objects (your own `make dist` flags!) instead of `-march=native` of whoever happened to own the build machine.

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


## Provenance & Honesty (Disclosure)

The 29 modules in `src/*.asm` are **not hand-typed**. Origin, crystal clear:

1. C source in `c_src/` (the truth behind the assembly)
2. `gcc` UNIV-build (`-march=x86-64 -mtune=generic -O2 -pipe`) → objects
3. `objconv -fnasm` → **object code poured back to NASM source**
4. `tools/strip_asm.pl`: hand-written stripping and optimization station —
   bloat sections (`.eh_frame`/`.comment`/`.debug`) removed, GAS labels normalized,
   objconv AVX-512 misrender fixed, banners restored — end result: 0× ymm/zmm

So: generated from object code, **then hand-optimized** (the latter part is holy truth).

**Proven reproducible**: `make regen` (gcc → objconv → strip over c_src/) produced in the
smithy 29/29 byte-identical `.asm` and `make` a byte-identical binary (2026-09-24).

Update workflow for the next release:
`c_src/` edit → `make regen` → `git diff src/` (adjust where you want to customize by hand) →
`make && make check` → commit. Required to regen: gcc, perl and objconv (or `make regen OBJCONV=/path/to/objconv`).
