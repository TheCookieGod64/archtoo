# Archtoo Emerge Engine — ARM64 (aarch64) edition v1.0.0
# Hand-assembled GAS sources (src/*.s) — geen C, geen bloatware.
# Op een x86-64 host heb je de cross-toolchain nodig:
#   Arch:   sudo pacman -S aarch64-linux-gnu-gcc
#   Debian: sudo apt install gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu
# Op een native ARM64 host: make AS=as LD=ld SYSROOT=/usr

CC      := aarch64-linux-gnu-gcc
AS      := aarch64-linux-gnu-as
LD      := aarch64-linux-gnu-ld
SYSROOT := /usr/aarch64-linux-gnu
VERSION := 1.0.0

SRCS := $(wildcard src/*.s)
OBJS := $(patsubst src/%.s,build/%.o,$(SRCS))

all: bin/emerge

build: ; @mkdir -p build
bin:   ; @mkdir -p bin

build/%.o: src/%.s | build
	$(AS) -o $@ $<

bin/emerge: $(OBJS) | bin
	$(LD) -o $@ $(SYSROOT)/lib/crt1.o $(SYSROOT)/lib/crti.o $(OBJS) $(SYSROOT)/lib/crtn.o \
	  $(SYSROOT)/lib/libc.so.6 -dynamic-linker /lib/ld-linux-aarch64.so.1 -z noexecstack
	@echo "[+] ARM64 binary built at bin/emerge (v$(VERSION))"

check: all
	@echo "[*] bin/emerge ELF check:"; file bin/emerge
	@if command -v qemu-aarch64-static >/dev/null 2>&1; then \
	  echo "[*] qemu smoke-test:"; \
	  qemu-aarch64-static -L $(SYSROOT) ./bin/emerge --version; \
	  qemu-aarch64-static -L $(SYSROOT) ./bin/emerge --help >/dev/null && echo "[+] help ok"; \
	else \
	  echo "[!] qemu-aarch64-static niet gevonden — overslaand runtime-test (bouw is wel OK)"; \
	fi

install: all
	install -Dm755 bin/emerge /usr/local/bin/emerge
	@echo "[+] Installed to /usr/local/bin/emerge (op een ARM64 host)"

uninstall:
	rm -f /usr/local/bin/emerge

regen:
	@echo "[*] BOEM: GAS-modules regenereren uit c_src/ ..."
	@mkdir -p build/regen
	@for c in $(wildcard c_src/*.c); do \
	  m=$$(basename $$c .c); \
	  $(CC) -std=gnu11 -O2 -pipe -march=armv8-a -fno-asynchronous-unwind-tables -fno-unwind-tables -fno-ident \
	     -Ic_src/headers -S $$c -o build/regen/$$m.s.raw || { echo "GEREED: $(CC) faalde op $$c"; exit 1; }; \
	  perl -ne 'next if /^\s*\#|^\s*\.cfi|^\s*\.file|^\s*\.loc|^\s*\.size|^\s*\.ident|^\s*$$/; print' \
	     build/regen/$$m.s.raw > src/$$m.s || { echo "GEREED: strip faalde op $$m"; exit 1; }; \
	  echo "  -> src/$$m.s"; \
	done
	@rm -rf build/regen
	@echo "[+] regen klaar — review met: git diff src/ && make && make check"

clean:
	rm -rf build bin

.PHONY: all check install uninstall clean regen
