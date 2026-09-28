# Changelog — Archtoo Emerge Engine, ARM64 Edition

## v1.2.2 — --binary auto-selects AUR binary variant (hotfix)

### Added
- Host-aware Makefile: on a native aarch64 host (Termux, ARM boards) the build uses plain
  `gcc`/`as` with no cross packages, no sysroot paths and no symlinks, and `make check`
  runs the binary directly; on other hosts it keeps the `aarch64-linux-gnu-*` cross
  toolchain and drives the smoke-test through `qemu-aarch64(-static)` when installed.
  Linking now goes through the detected compiler, so startup objects and libc come from
  the host toolchain itself (still `-z noexecstack`).

### Fixed
- `emerge --binary NAME` now installs the AUR "-bin" variant it finds (e.g. shelly ->
  shelly-bin) instead of only printing a tip and falling back to a source build.
- `emerge --binary NAME-bin` no longer searches `NAME-bin-bin` and no longer mislabels a
  prebuilt package as "source build only": the target itself is recognized as the
  binary variant and the source path is taken directly (makepkg only repackages).
- install_build_dependencies: split packages whose siblings depend on the build target
  itself (e.g. shelly-bin's flatpak package: depends=("shelly-bin=${pkgver}")) no longer
  try `pacman -S` on the package being built; names built or provided by the same
  PKGBUILD are subtracted before resolution. Dependency parsing also matches the
  singular srcinfo keys (depend/makedepend/checkdepend), which the old regex missed
  entirely, so real build deps are no longer silently skipped.

## v1.2.0 — makepkg_raw: raw options for makepkg itself

### Added
- `makepkg_raw = --flag --flag` (alias key `makepkg_flags`) in
  `~/.config/archtoo/config`: plain option tokens passed straight to every `makepkg`
  run the engine starts (source builds and `emerge -B` local builds). Typical use:
  `makepkg_raw = --nocheck` to skip slow check() phases globally (e.g. zstd's test
  suite) without editing anyone's PKGBUILD; upgrades keep working because upstream
  PKGBUILDs are still fetched fresh. The same guard as `--raw` applies: plain
  tokens only, no shell metacharacters, <= 192 chars; lines that fail validation
  are rejected as invalid config and never reach a shell.

## v1.1.1 — Gentoo chroot imitation: real artifact installation

### Changed
- `--imitation` merges now really install onto the host: after Portage finishes, the engine
  locates the freshly merged CPV under the chroot's `/var/db/pkg`, parses its Portage `CONTENTS`
  manifest and replays it on the host through a hardened `install -d` / `cp -a` / `ln -sfn`
  script (symlinks keep the relative target from CONTENTS). The whole `/usr/**` tree maps onto
  `/usr/local/**`; `/etc`, `/var` and other prefixes are never copied — the imitation cannot
  clobber the live host (skipped entries are counted and reported).

### Added
- A reverse manifest `/usr/local/emerge/chroot-world/<pkg>` is written for every imitation merge
  (one `obj|sym|dir <host path>` line per installed entry) and the package is registered in `world`.
- `emerge -C <pkg>` now understands chroot-world packages: every manifest entry is removed
  (`rm -f` for files and symlinks, `rmdir -p --ignore-fail-on-non-empty` for dirs), the entry is
  deselected from `world` and the manifest is deleted. The chroot's own vdb is left untouched.
  A path guard refuses manifest lines outside `/usr/local/`.

### Fixed
- Imitation merges no longer report success while installing nothing: the old fake
  "Copying artifacts" echo is replaced by the real copy stage; a failure there fails the emerge
  with a non-zero exit.

## v1.1.0 — --raw flag + AUR-binary-jacht hardening

### Added
- `--raw "FLAGS"` (`--raw=FLAGS`, config key `raw = ...`): raw compiler options
  appended to the generated CFLAGS/CXXFLAGS and to LDFLAGS of every source build,
  e.g. `emerge --raw "-march=native -fuse-ld=mold" pkg`. Only plain option tokens
  are accepted (no shell metacharacters) because the string lands in a re-sourced
  makepkg.conf. RUSTFLAGS are untouched by design.

### Fixed
- GAS/AArch64 regen pipeline: objconv could not resolve jump-table entries pointing at
  cold `.text.unlikely` labels; those entries were anchored to the nearest global
  with a constant offset and broke once the linker relocated sections — causing a
  SIGSEGV whenever dense switches ran real-world data (observed while parsing AUR
  descriptions containing `\u` escapes). Regeneration now uses `-fno-jump-tables`.
- `parse_json_string`: hardened against truncated JSON (curl read cap): a
  backslash at end-of-buffer no longer reads past the string, and the output
  index is bounded by capacity.

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
