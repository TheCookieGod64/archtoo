# Archtoo Emerge Engine — i686 (32-bit x86, NASM) edition  [x86 branch]
#
# Host-aware build, mirroring main v3.2.2 / arm v1.2.2:
#   - i386-family host (rare real 32-bit box or 32-bit container): native, no -m32.
#   - x86_64 host: builds the 32-bit binary via the gcc multilib route (-m32);
#     needs the 32-bit glibc (Arch: enable [multilib], pacman -S lib32-glibc).
#   - any other host: stops with a clear hint (no sane i686 cross there).
# `make check` runs the binary under qemu-i386(-static) when available, so the
# smoke-test also passes on an x86_64 workstation.
# Keep in sync with c_src/headers/version.h
VERSION     = 1.0.0

HOST_ARCH := $(shell uname -m)
M32 :=
QEMU :=
ifeq ($(HOST_ARCH),x86_64)
  M32       := -m32
  QEMU      := $(firstword $(shell command -v qemu-i386-static || command -v qemu-i386))
  ifneq ($(QEMU),)
    RUN_BIN := $(QEMU) -L /usr ./bin/emerge
  else
    RUN_BIN := :
  endif
  HOSTMODE  := x86_64 host, -m32 multilib
else ifneq (,$(filter $(HOST_ARCH),i386 i486 i586 i686))
  RUN_BIN   := ./bin/emerge
  HOSTMODE  := native i686
else
  RUN_BIN   := :
  HOSTMODE  := unsupported host
endif

NASM        ?= nasm
NASFLAGS    = -f elf32 -Iheaders/
CC          ?= gcc
LD          ?= ld

SRC_DIR     = src
HDR_DIR     = headers
BUILD_DIR   = build
BIN_DIR     = bin
DIST_DIR    = dist

TARGET      = $(BIN_DIR)/emerge

DESTDIR     ?=
PREFIX      ?= /usr/local
BINDIR      ?= $(PREFIX)/bin

# crt / libc paths resolved through gcc, so this Makefile works on Arch and
# Debian alike without hardcoding FHS quirks.
CRT1   := $(shell $(CC) $(M32) -print-file-name=crt1.o)
CRTI   := $(shell $(CC) $(M32) -print-file-name=crti.o)
CRTN   := $(shell $(CC) $(M32) -print-file-name=crtn.o)
LIBC   := $(shell $(CC) $(M32) -print-file-name=libc.so.6)
DYNLNK := $(shell $(CC) $(M32) -print-file-name=ld-linux.so.2)

OBJS = $(patsubst $(SRC_DIR)/%.asm,$(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.asm))

all: $(TARGET)

$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(NASM) $(NASFLAGS) $< -o $@

# Static relink: our objects carry only local relocations + libc imports,
# so plain ld + glibc crt is enough (no PIE gymnastics needed).
$(TARGET): $(OBJS) | $(BIN_DIR)
	@case "$(HOST_ARCH)" in i386|i486|i586|i686|x86_64) ;; \
	  *) echo "[-] x86 branch: build on an i686 host, or on x86_64 with 32-bit multilib (Arch: enable [multilib] in /etc/pacman.conf, then sudo pacman -S lib32-glibc)"; exit 1;; \
	esac
	$(LD) -m elf_i386 -o $@ $(CRT1) $(CRTI) $(OBJS) $(CRTN) $(LIBC) -dynamic-linker $(DYNLNK) -z noexecstack
	@echo "[+] NASM binary built at $@ (v$(VERSION), $(HOSTMODE))"

check: $(TARGET)
	@echo "[*] bin/emerge ELF check:"; file bin/emerge
	@if [ "$(RUN_BIN)" != ":" ]; then \
	  echo "[*] runtime smoke-test ($(HOSTMODE)):"; \
	  $(RUN_BIN) --version; \
	  $(RUN_BIN) --help >/dev/null && echo "[+] help ok"; \
	else \
	  echo "[!] could not run the i686 binary here (no qemu-i386?) — skipping smoke-test (build itself is OK)"; \
	fi

dist: $(TARGET)
	mkdir -p $(DIST_DIR)
	tar -czf archtoo-v$(VERSION)-nasm-linux-x86_64.tar.gz $(SRC_DIR) $(HDR_DIR) Makefile README.md CHANGELOG.md LICENSE LICENSE.CKL
	@echo "[+] source archive built"

# ---- regeneratie: BOEM C -> obj -> objconv -> strip -> src/*.asm (byte-idem geverifieerd) ----
CC      := cc
UNIV_CFLAGS := $(M32) -march=i686 -mtune=generic -O2 -pipe -fno-jump-tables -fno-pic -fno-pie  # non-PIE: geen __x86.get_pc_thunk dubbele definities bij losse asm-modules  # objconv kan geen .text.unlikely-labels in jump-tables resolven -> tables verbieden
OBJCONV ?= objconv

regen:
	@command -v $(OBJCONV) >/dev/null 2>&1 || [ -x "$(OBJCONV)" ] || { echo "[-] objconv niet gevonden: sudo pacman -S ... of maak: make regen OBJCONV=/pad/naar/objconv"; exit 1; }
	@mkdir -p build/regen
	@for c in $(wildcard c_src/*.c); do m=$$(basename $$c .c); \
	  $(CC) $(UNIV_CFLAGS) -Ic_src/headers -c $$c -o build/regen/$$m.o || { echo "GEREED: cc faalde op $$c"; exit 1; }; \
	  $(OBJCONV) -fnasm build/regen/$$m.o build/regen/$$m.raw >/dev/null || { echo "GEREED: objconv faalde op $$m"; exit 1; }; \
	  perl tools/strip_asm.pl build/regen/$$m.raw src/$$m.asm $$m || { echo "GEREED: strip faalde op $$m"; exit 1; }; \
	  echo "  -> src/$$m.asm"; \
	done
	@rm -rf build/regen
	@echo "[+] regen klaar — review: git diff src/ ; daarna: make && make check"

clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)
	@echo "[+] Build directories cleaned"

# No sudo inside the recipe: run "sudo make install" yourself.
install: $(TARGET)
	install -Dm755 $(TARGET) $(DESTDIR)$(BINDIR)/emerge
	@echo "[+] Installed to $(DESTDIR)$(BINDIR)/emerge"

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/emerge
	@echo "[-] Removed from $(DESTDIR)$(BINDIR)/emerge"

.PHONY: all check dist clean install uninstall
