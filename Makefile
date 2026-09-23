# Archtoo Emerge Engine — ARM64 (aarch64) edition v1.0.0
# Hand-assembled GAS sources (src/*.s) — geen C, geen bloatware.
# Op een x86-64 host heb je de cross-toolchain nodig:
#   Arch:   sudo pacman -S aarch64-linux-gnu-gcc
#   Debian: sudo apt install gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu
# Op een native ARM64 host: make AS=as LD=ld SYSROOT=/usr

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

clean:
	rm -rf build bin

.PHONY: all check install uninstall clean
