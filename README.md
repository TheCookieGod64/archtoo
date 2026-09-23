# Archtoo Emerge Engine — ARM64 Edition v1.0.0

Handgeschreven **GAS-assembly** (`.s`, AArch64) — de ARM64-tak van de Archtoo-familie.
Port van de x86-64 NASM-editie v3.0.0, opnieuw gesmeed voor armv8: 29 modules, nul
compiler-bloatware (`.cfi`/`.loc`/`.ident` eruit geslepen), alleen `as` + `ld` nodig.

> Waarom geen NASM op ARM? NASM kent geen AArch64-back-end. Deze editie gebruikt daarom
> GNU-assembler-syntax — zelfde principe, zelfde nul-bloatware-ritueel, andere heilige tekst.

## Specificaties

| | |
|---|---|
| ISA-baseline | **armv8.0-A** (FP/ASIMD zoals élke Linux-ARM64-CPU: Pi3/4/5, RK33xx, Snapdragon, Apple M) |
| Modules | 29 × `src/*.s` (GAS) |
| Link | direct `ld` → libc, `-z noexecstack`, interp `/lib/ld-linux-aarch64.so.1` |
| Versie | **v1.0.0** — de ARM-tak begint opnieuw, onafhankelijk van de x86-v3.x-tellingen |
| Licenties | GPL-3.0-only (code) + CKL (docs) |

## Werking

Identiek aan de x86-editie: pacman-first, AUR via `aur_rpc`, PKGBUILD-fetch, makepkg-aanroep
met `SUDO_UID/GID`, sha256-verificatie, transacties met backup/restore, `--binary` repo-first mode.

## Bouwen

```bash
# Op x86-64 (cross): gereedschap first
sudo pacman -S aarch64-linux-gnu-gcc         # Arch   (apt: gcc-aarch64-linux-gnu)
make && make check                            # check draait onder qemu als het kan

# Op native ARM64
make AS=as LD=ld SYSROOT=/usr && sudo make install
```

## Testen via qemu op een x86-host (optioneel)

```bash
sudo pacman -S qemu-user-static              # Arch
qemu-aarch64-static -L /usr/aarch64-linux-gnu ./bin/emerge --version
```

## Structuur

```
archtoo/
├── Makefile          # as + ld flow, VERSION 1.0.0
├── src/*.s           # 29 GAS-modules
├── README.md  CHANGELOG.md  LICENSE  LICENSE.CKL  .gitignore
```

Geen `headers/`-map nodig: GAS externals hoeven geen declaraties — `ld` lost alles op.
