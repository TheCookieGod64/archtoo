# Keep in sync with headers/archtoo.inc
VERSION     = 3.0.0

NASM        ?= nasm
NASFLAGS    = -f elf64 -Iheaders/
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
CRT1   := $(shell $(CC) -print-file-name=crt1.o)
CRTI   := $(shell $(CC) -print-file-name=crti.o)
CRTN   := $(shell $(CC) -print-file-name=crtn.o)
LIBC   := $(shell $(CC) -print-file-name=libc.so.6)
DYNLNK := $(shell $(CC) -print-file-name=ld-linux-x86-64.so.2)

OBJS = $(patsubst $(SRC_DIR)/%.asm,$(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.asm))

all: $(TARGET)

$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(NASM) $(NASFLAGS) $< -o $@

# Static relink: our objects carry only local relocations + libc imports,
# so plain ld + glibc crt is enough (no PIE gymnastics needed).
$(TARGET): $(OBJS) | $(BIN_DIR)
	$(LD) -o $@ $(CRT1) $(CRTI) $(OBJS) $(CRTN) $(LIBC) -dynamic-linker $(DYNLNK) -z noexecstack
	@echo "[+] NASM binary built at $@"

check: $(TARGET)
	@./$(TARGET) --version
	@echo "[+] binary runs; no undefined symbols"

dist: $(TARGET)
	mkdir -p $(DIST_DIR)
	tar -czf archtoo-v$(VERSION)-nasm-linux-x86_64.tar.gz $(SRC_DIR) $(HDR_DIR) Makefile README.md CHANGELOG.md LICENSE LICENSE.CKL
	@echo "[+] source archive built"

# ---- regeneratie: BOEM C -> obj -> objconv -> strip -> src/*.asm (byte-idem geverifieerd) ----
CC      := cc
UNIV_CFLAGS := -march=x86-64 -mtune=generic -O2 -pipe
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
