# Archtoo Emerge Engine — ARMv7 32-bit (hard-float, GAS) edition  [arm-32 branch]
#
# Host-aware build, mirroring the arm64 branch (v1.2.2 design):
#   - armv7/armv6 host (older phone, Raspberry Pi in 32-bit mode, ...): fully
#     NATIVE — plain gcc/as from the distro, no cross packages, check RUNS.
#   - anything else (x86_64 workstation, aarch64 phone): cross-compiles via
#     the arm-linux-gnueabihf-* toolchain (Arch: pacman -S arm-linux-gnueabihf-gcc)
#     and runs the smoke-test under qemu-arm(-static) when available.
# Target ISA: armv7-a + NEON + hard-float EABI (the Arch Linux ARM armv7 baseline).

VERSION := 1.0.0

HOST_ARCH := $(shell uname -m)
ARCH_FLAGS := -march=armv7-a -mfpu=neon -mfloat-abi=hard

ifeq (,$(filter $(HOST_ARCH),armv7l armv6l armv8l arm))
  TC        := arm-linux-gnueabihf-
  SYSROOT   := /usr/arm-linux-gnueabihf
  QEMU      := $(firstword $(shell command -v qemu-arm-static || command -v qemu-arm))
  ifneq ($(QEMU),)
    RUN_BIN := $(QEMU) -L $(SYSROOT) ./bin/emerge
  else
    RUN_BIN := :
  endif
  HOSTMODE  := cross $(TC) -> armv7 hardfp
else
  TC        :=
  RUN_BIN   := ./bin/emerge
  HOSTMODE  := native $(HOST_ARCH) hardfp
endif

CC      := $(TC)gcc
AS      := $(TC)as
LD      := $(TC)ld
AR      := $(TC)ar
STRIP   := $(TC)strip

SYSROOT ?= /usr/arm-linux-gnueabihf

SRCS := $(wildcard src/*.s)
OBJS := $(patsubst src/%.s,build/%.o,$(SRCS))

all: bin/emerge

build: ; @mkdir -p build
bin:   ; @mkdir -p bin

build/%.o: src/%.s | build
	$(AS) $(ARCH_FLAGS) -o $@ $<

bin/emerge: $(OBJS) | bin
	$(CC) $(ARCH_FLAGS) -Wl,-z,noexecstack -Wl,--as-needed -o $@ $(OBJS) -latomic
	@echo "[+] ARMv7 binary built at $@ (v$(VERSION), $(HOSTMODE))"

check: all
	@echo "[*] bin/emerge ELF check:"; file bin/emerge
	@if [ "$(RUN_BIN)" != ":" ]; then \
	  echo "[*] runtime smoke-test ($(HOSTMODE)):"; \
	  $(RUN_BIN) --version; \
	  $(RUN_BIN) --help >/dev/null && echo "[+] help ok"; \
	else \
	  echo "[!] no qemu-arm found for the cross-run smoke-test — skipping (the build itself is OK; install e.g. 'qemu-user-static' to enable it)"; \
	fi

# ---- regen: (re)generate src/*.s from c_src/*.c with the detected $(CC) ----
regen:
	@echo "[*] BOEM: GAS-modules regenereren uit c_src/ ($(HOSTMODE))..."
	@mkdir -p build/regen
	@for c in $(wildcard c_src/*.c); do \
	  m=$$(basename $$c .c); \
	  $(CC) -std=gnu11 -O2 -pipe $(ARCH_FLAGS) -fno-asynchronous-unwind-tables -fno-unwind-tables -fno-ident \
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
