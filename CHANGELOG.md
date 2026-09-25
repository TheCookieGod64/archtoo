# Changelog — Archtoo Emerge Engine, ARM64 Edition

## v1.0.0 — 2026-09-21 — ARM64 Edition, eerste release

Eerste zelfstandige publicatie van de ARM64-tak: de volledige Emerge Engine
(portable baseline x86-64 v3.0.0-editie) is overgesmeed naar **AArch64 GAS-assembly**.

- **29 modules** `src/*.s`, gegenereerd uit de C-bron en daarna met de hand kaalgeknipt
  (alle `.cfi_*`, `.loc`, `.file`, `.size`, `.ident` en commentaar-bloatware verwijderd)
- **armv8.0-A-baseline**: draait op elke Linux-ARM64-CPU; geen single-core-exotica
- Linken direct met `as` + `ld` (geen gcc-driver), `-z noexecstack`,
  interpreter `/lib/ld-linux-aarch64.so.1`
- Versielijn starts here: de ARM-telclock is **onafhankelijk** van x86 (v3.x);
  banner, CHANGELOG en Makefile ademen 1.0.0
- Feature-pariteit met x86 v3.0.0: pacman/AUR-flow, `--binary` repo-first,
  transactie-backups, sha256, `SUDO_UID`-correcte makepkg-aanroep
- Verifieerd: build + `--version`/`--help` gedraaid onder qemu-aarch64, banner toont v1.0.0

---

De x86-64-geschiedenis (v1.0 → v2.4 C-era, v3.0.0 NASM-port) staat in de CHANGELOG
op de `main`-branch; deze branch is de ARM64-fork van dat verhaal.

### Tooling-update 2026-09-24 (geen versiebump — binary unchanged)
- `c_src/` toegevoegd: 29 C-modules + headers (versie 1.0.0) als regen-bron
- `make regen` + `tools/strip_gcc_asm.pl`: C → cross-gcc -S → kaalgeknipte `.s`; in de smid bewezen 29/29 byte-identiek
- Provenance-sectie in README: gegenereerd uit de C-toolchain-flow, daarna met de hand kaalgeknipt en nagelopen
