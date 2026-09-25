# Archtoo Emerge Engine — ARM64 Edition v1.0.0

Hand-written **GAS-assembly** (`.s`, AArch64) — the ARM64 branch of the Archtoo family.
Port of the x86-64 NASM edition v3.0.0, re-forged for armv8: 29 modules, zero
compiler bloatware (`.cfi`/`.loc`/`.ident` stripped), `as` + `ld` only.

> Why not NASM on ARM? NASM has no AArch64 back-end. This edition uses
> GNU assembler syntax instead — same principle, same zero-bloatware ritual, different holy text.

## Specifications

| | |
|---|---|
| ISA baseline | **armv8.0-A** (FP/ASIMD like every Linux-ARM64 CPU: Pi3/4/5, RK33xx, Snapdragon, Apple M) |
| Modules | 29 × `src/*.s` (GAS) |
| Link | direct `ld` → libc, `-z noexecstack`, interp `/lib/ld-linux-aarch64.so.1` |
| Version | **v1.0.0** — the ARM branch starts fresh, independent of x86 v3.x counts |
| Licenses | GPL-3.0-only (code) + CKL (docs) |

## Operation

Identical to the x86 edition: pacman-first, AUR via `aur_rpc`, PKGBUILD-fetch, makepkg call
with `SUDO_UID/GID`, sha256 verification, transactions with backup/restore, `--binary` repo-first mode.

## Building

```bash
# On x86-64 (cross): tooling first
sudo pacman -S aarch64-linux-gnu-gcc         # Arch   (apt: gcc-aarch64-linux-gnu)
make && make check                            # check runs under qemu if available

# On native ARM64
make AS=as LD=ld SYSROOT=/usr && sudo make install
```

## Testing via qemu on an x86 host (optional)

```bash
sudo pacman -S qemu-user-static              # Arch
qemu-aarch64-static -L /usr/aarch64-linux-gnu ./bin/emerge --version
```

## Structure

```
archtoo/
├── Makefile          # as + ld flow, VERSION 1.0.0
├── src/*.s           # 29 GAS modules
├── README.md  CHANGELOG.md  LICENSE  LICENSE.CKL  .gitignore
```

No `headers/` directory needed: GAS externals don't need declarations — `ld` resolves everything.


## Provenance & Honesty (Disclosure)

The 29 modules in `src/*.s` are **not hand-typed**. Origin:

1. C source in `c_src/` (with `headers/`, version.h = 1.0.0)
2. `aarch64-linux-gnu-gcc -S` (armv8-A, -O2, no unwind-tables) → GAS assembly
3. `tools/strip_gcc_asm.pl`: stripping station — `.cfi_*`/`.loc`/`.file`/`.size`/`.ident` bloat removed,
   hand-reviewed for cleanliness and readability

On this branch no objconv (that's the x86 edition's tool); GAS is the standard here —
the same choice the Linux kernel itself makes on arm64.

**Proven reproducible**: `make regen` produced 29/29 byte-identical `.s` and `make` a
byte-identical binary (smithy-verification 2026-09-24).

Update workflow: `c_src/` edit → `make regen` → `git diff src/` → `make && make check` → commit.
