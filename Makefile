# Archtoo Emerge Engine — ARM64 (aarch64) edition
#
# Toolchain auto-detection (v1.2.2+): the build adapts to the HOST it runs on.
#   - aarch64 host (Termux on a phone, any ARM board): fully NATIVE — plain
#     gcc/as, no cross packages, no sysroot, and `make check` actually RUNS
#     the binary. No random symlinks needed anymore.
#   - anything else (x86_64 workstation): cross-compiles via the
#     aarch64-linux-gnu-* toolchain and `make check` runs the result under
#     qemu-aarch64(-static) when available, else reports the skip politely.
# Linking goes through $(CC) in both cases so startup objects/libc come from
# the host's own toolchain — that is what makes Termux "just work" while the
# cross branch keeps the same -z noexecstack hardening.

VERSION := 1.2.2

HOST_ARCH := $(shell uname -m)
ifeq ($(HOST_ARCH),aarch64)
  TC        :=
  RUN_BIN   := ./bin/emerge
  HOSTMODE  := native aarch64
else
  TC        := aarch64-linux-gnu-
  SYSROOT   := /usr/aarch64-linux-gnu
  QEMU      := $(firstword $(shell command -v qemu-aarch64-static || command -v qemu-aarch64))
  ifneq ($(QEMU),)
    RUN_BIN := $(QEMU) -L $(SYSROOT) ./bin/emerge
  else
    RUN_BIN := :
  endif
  HOSTMODE  := cross $(TC) -> aarch64
endif

CC      := $(TC)gcc
AS      := $(TC)as
LD      := $(TC)ld
AR      := $(TC)ar
STRIP   := $(TC)strip

SYSROOT ?= /usr/aarch64-linux-gnu

SRCS := $(wildcard src/*.s)
OBJS := $(patsubst src/%.s,build/%.o,$(SRCS))

all: bin/emerge

build: ; @mkdir -p build
bin:   ; @mkdir -p bin

build/%.o: src/%.s | build
	$(AS) -o $@ $<

bin/emerge: $(OBJS) | bin
	$(CC) -Wl,-z,noexecstack -o $@ $(OBJS)
	@echo "[+] ARM64 binary built at $@ (v$(VERSION), $(HOSTMODE))"

check: all
	@echo "[*] bin/emerge ELF check:"; file bin/emerge
	@if [ -n "$(QEMU)$(filter aarch64,$(HOST_ARCH))" ] && [ "$(RUN_BIN)" != ":" ]; then \
	  echo "[*] runtime smoke-test ($(HOSTMODE)):"; \
	  $(RUN_BIN) --version; \
	  $(RUN_BIN) --help >/dev/null && echo "[+] help ok"; \
	else \
	  echo "[!] no qemu-aarch64 found for the cross-run smoke-test — skipping (the build itself is OK; install e.g. 'qemu-user-static' to enable it)"; \
	fi

# ---- regen: (re)generate src/*.s from c_src/*.c with the detected $(CC) ----
regen:
	@echo "[*] BOEM: GAS-modules regenereren uit c_src/ ($(HOSTMODE))..."
	@mkdir -p build/regen
	@for c in $(wildcard c_src/*.c); do \
	  m=$$(basename $$c .c); \
	  $(CC) -std=gnu11 -O2 -pipe -march=armv8-a -fno-asynchronous-unwind-tables -fno-unwind-tables -fno-ident \
	     -Ic_src/headers -S $$c -o build/regen/$$m.s.raw || { echo "GEREED: $(CC) faalde op $$c"; exit 1; }; \
	  perl -ne 'next if /^\s*\#|^\s*\.cfi|^\s*\.file|^\s*\.loc|^\s*\.size|^\s*\.ident|^\s*\.eabi_attribute|^\s*\.aeabi_attribute|^\s*$$/; print' \
	     build/regen/$$m.s.raw > src/$$m.s || { echo "GEREED: strip faalde op $$m"; exit 1; }; \
	  echo "  -> src/$$m.s"; \
	done
	@rm -rf build/regen
	@echo "[+] regen klaar — review met: git diff src/ && make && make check"

clean:
	rm -rf build bin

.PHONY: all check regen clean
