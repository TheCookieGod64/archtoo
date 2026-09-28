# Archtoo Emerge Engine — dev: unified multi-target build
#
# ONE c_src/ produces every binary:
#   make                    x86_64 only, as always            -> bin/emerge
#   make all                x86_64 + x86 + arm + arm-32       -> bin/<t>/emerge each
#   make x86_64|x86|arm|arm-32      single target
#   make check              smoke bin/emerge (qemu-x86_64 on foreign hosts when present)
#   make check-all          smoke every binary that exists under bin/
#   make regen              refresh the TRACKED x86_64 asm (src/*.asm) — the other targets
#                           generate their asm from c_src/ on the fly into build/<t>/,
#                           so the tree only ever tracks x86_64 assembly.
#
# Host-aware per target (mirrors the branches): native where possible, cross where a
# toolchain exists, qemu for the smoke-run, polite skip otherwise.
# Keep in sync with headers/archtoo.inc
VERSION     = 3.0.0

SRC_DIR     = src
HDR_DIR     = headers
BUILD_DIR   = build
BIN_DIR     = bin
DIST_DIR    = dist

NASM        ?= nasm
LD          ?= ld
OBJCONV     ?= objconv
HOST_ARCH   := $(shell uname -m)
have  = $(shell command -v $(1) >/dev/null 2>&1 && echo 1)
QFIND = $(if $(call have,$(1)-static),$(1)-static,$(if $(call have,$(1)),$(1),))

# default goal stays x86_64-only for CI and muscle memory:
native: $(BIN_DIR)/emerge
all: x86_64 x86 arm arm-32
x86_64: $(BIN_DIR)/emerge
x86: $(BIN_DIR)/x86/emerge
arm: $(BIN_DIR)/arm/emerge
arm-32: $(BIN_DIR)/arm-32/emerge

# --------------------------------------------------------------- x86_64
# Tracked asm + nasm + raw ld, crt/libc resolved through a host- (or cross-) gcc.
ifeq ($(HOST_ARCH),x86_64)
  CC        ?= gcc
  X64RUN    := $(BIN_DIR)/emerge
else
  ifneq ($(call have,x86_64-linux-gnu-gcc),)
    CC      := x86_64-linux-gnu-gcc
    LD      := x86_64-linux-gnu-ld
  endif
  Q64       := $(call QFIND,qemu-x86_64)
  X64RUN    := $(if $(Q64),$(Q64) -L /usr ,)$(BIN_DIR)/emerge
endif
CC          ?= gcc
CRT1   := $(shell $(CC) -print-file-name=crt1.o)
CRTI   := $(shell $(CC) -print-file-name=crti.o)
CRTN   := $(shell $(CC) -print-file-name=crtn.o)
LIBC   := $(shell $(CC) -print-file-name=libc.so.6)
DYNLNK := $(shell $(CC) -print-file-name=ld-linux-x86-64.so.2)
OBJS = $(patsubst $(SRC_DIR)/%.asm,$(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.asm))

$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(NASM) -f elf64 -Iheaders/ $< -o $@

$(BIN_DIR)/emerge: $(OBJS) | $(BIN_DIR)
ifeq ($(HOST_ARCH),x86_64)
else ifeq ($(call have,$(CC)),)
	@echo "[-] x86_64 host needed, or an x86_64 cross-gcc providing $(CC)"; exit 1
endif
	$(LD) -o $@ $(CRT1) $(CRTI) $(OBJS) $(CRTN) $(LIBC) -dynamic-linker $(DYNLNK) -z noexecstack
	@echo "[+] x86_64 binary built at $@ (v$(VERSION))"

# --------------------------------------------------------------- x86 (i686)
M32 :=
ifeq ($(HOST_ARCH),x86_64)
  M32 := -m32
endif
X86OK := $(or $(filter i386 i486 i586 i686,$(HOST_ARCH)),$(filter x86_64,$(HOST_ARCH)))
Q32   := $(call QFIND,qemu-i386)
X86RUN := $(if $(Q32),$(Q32) -L / ,)$(BIN_DIR)/x86/emerge
X86_CRT1 := $(shell $(CC) $(M32) -print-file-name=crt1.o)
X86_CRTI := $(shell $(CC) $(M32) -print-file-name=crti.o)
X86_CRTN := $(shell $(CC) $(M32) -print-file-name=crtn.o)
X86_LIBC := $(shell $(CC) $(M32) -print-file-name=libc.so.6)
X86_DYN  := $(shell $(CC) $(M32) -print-file-name=ld-linux.so.2)

$(BUILD_DIR)/x86: ; @mkdir -p $@
$(BIN_DIR)/x86:   ; @mkdir -p $@

# c_src -> i686 object -> objconv -> strip -> .asm (all inside build/, nothing tracked)
$(BUILD_DIR)/x86/%.asm: c_src/%.c | $(BUILD_DIR)/x86
	@command -v $(OBJCONV) >/dev/null 2>&1 || [ -x "$(OBJCONV)" ] || { echo "[-] objconv missing (needed to generate i686 asm)"; exit 1; }
	$(CC) $(M32) -march=i686 -mtune=generic -O2 -pipe -fno-jump-tables -fno-pic -fno-pie -Ic_src/headers -c $< -o $(BUILD_DIR)/x86/$*.o
	$(OBJCONV) -fnasm $(BUILD_DIR)/x86/$*.o $(BUILD_DIR)/x86/$*.raw >/dev/null
	perl tools/strip_asm.pl $(BUILD_DIR)/x86/$*.raw $@ $*

$(BUILD_DIR)/x86/%.o: $(BUILD_DIR)/x86/%.asm | $(BUILD_DIR)/x86
	$(NASM) -f elf32 -Iheaders/ $< -o $@

X86_OBJS = $(patsubst c_src/%.c,$(BUILD_DIR)/x86/%.o,$(wildcard c_src/*.c))
$(BIN_DIR)/x86/emerge: $(X86_OBJS) | $(BIN_DIR)/x86
	@if [ -z "$(X86OK)" ]; then echo "[-] i686 build needs an i686 host or x86_64 with 32-bit multilib (Arch: enable [multilib], sudo pacman -S lib32-glibc)"; exit 1; fi
	@if [ "$(X86_CRT1)" = "crt1.o" ]; then echo "[-] host is right but 32-bit crt not found: install multilib glibc (Arch: [multilib] + lib32-glibc)"; exit 1; fi
	$(LD) -m elf_i386 -o $@ $(X86_CRT1) $(X86_CRTI) $(X86_OBJS) $(X86_CRTN) $(X86_LIBC) -dynamic-linker $(X86_DYN) -z noexecstack
	@echo "[+] i686 binary built at $@ (v$(VERSION), $(if $(M32),-m32 multilib,native i686))"

# --------------------------------------------------------------- GAS helper
# aarch64/armv7: same 'compile C to asm' idea as the branches' regen, inline:
GAS_STRIP = perl -ne 'next if /^\s*\#|^\s*\.cfi|^\s*\.file|^\s*\.loc|^\s*\.size|^\s*\.ident|^\s*\.eabi_attribute|^\s*\.aeabi_attribute|^\s*$$/; print'

# --------------------------------------------------------------- arm (aarch64)
ifeq ($(HOST_ARCH),aarch64)
  ARM_CC := gcc
  ARM_AS := as
  ARMRUN := $(BIN_DIR)/arm/emerge
else
  ifneq ($(call have,aarch64-linux-gnu-gcc),)
    ARM_TC := aarch64-linux-gnu-
  else ifneq ($(call have,aarch64-none-linux-gnu-gcc),)
    ARM_TC := aarch64-none-linux-gnu-
  else
    ARM_TC :=
  endif
  ARM_CC := $(ARM_TC)gcc
  ARM_AS := $(ARM_TC)as
  QA    := $(call QFIND,qemu-aarch64)
  ASYS  := $(if $(ARM_TC),$(shell $(ARM_CC) -print-sysroot),)
  ARMRUN := $(if $(QA),$(QA) $(if $(ASYS),-L $(ASYS),) ,)$(BIN_DIR)/arm/emerge
endif
GAS_CFLAGS = -std=gnu11 -O2 -pipe -fno-asynchronous-unwind-tables -fno-unwind-tables -fno-ident -Ic_src/headers

$(BUILD_DIR)/arm: ; @mkdir -p $@
$(BIN_DIR)/arm:   ; @mkdir -p $@
$(BUILD_DIR)/arm/%.s: c_src/%.c | $(BUILD_DIR)/arm
	@if [ -z "$(ARM_CC)" ] || ! command -v $(ARM_CC) >/dev/null 2>&1; then echo "[-] aarch64 host or aarch64-linux-gnu-/aarch64-none-linux-gnu- gcc needed"; exit 1; fi
	$(ARM_CC) $(GAS_CFLAGS) -march=armv8-a -S $< -o $@.raw && $(GAS_STRIP) < $@.raw > $@ && rm -f $@.raw
$(BUILD_DIR)/arm/%.o: $(BUILD_DIR)/arm/%.s | $(BUILD_DIR)/arm
	$(ARM_AS) -o $@ $<
ARM_OBJS = $(patsubst c_src/%.c,$(BUILD_DIR)/arm/%.o,$(wildcard c_src/*.c))
$(BIN_DIR)/arm/emerge: $(ARM_OBJS) | $(BIN_DIR)/arm
	$(ARM_CC) -Wl,-z,noexecstack -o $@ $(ARM_OBJS)
	@echo "[+] aarch64 binary built at $@ (v$(VERSION), $(if $(filter aarch64,$(HOST_ARCH)),native aarch64,cross $(ARM_TC)))"

# --------------------------------------------------------------- arm-32 (armv7hf)
A32F := -march=armv7-a -mfpu=neon -mfloat-abi=hard
ifeq (,$(filter $(HOST_ARCH),armv7l armv6l armv8l arm))
  ifneq ($(call have,arm-linux-gnueabihf-gcc),)
    A32_TC := arm-linux-gnueabihf-
  else ifneq ($(call have,arm-none-linux-gnueabihf-gcc),)
    A32_TC := arm-none-linux-gnueabihf-
  else
    A32_TC :=
  endif
  A32_CC := $(A32_TC)gcc
  A32_AS := $(A32_TC)as
  Q32A  := $(call QFIND,qemu-arm)
  A32SYS := $(if $(A32_TC),$(shell $(A32_CC) -print-sysroot),)
  A32RUN := $(if $(Q32A),$(Q32A) $(if $(A32SYS),-L $(A32SYS),) ,)$(BIN_DIR)/arm-32/emerge
else
  A32_CC := gcc
  A32_AS := as
  A32RUN := $(BIN_DIR)/arm-32/emerge
endif

$(BUILD_DIR)/arm-32: ; @mkdir -p $@
$(BIN_DIR)/arm-32:   ; @mkdir -p $@
$(BUILD_DIR)/arm-32/%.s: c_src/%.c | $(BUILD_DIR)/arm-32
	@if [ -z "$(A32_CC)" ] || ! command -v $(A32_CC) >/dev/null 2>&1; then echo "[-] armv7 host or arm-linux-gnueabihf-/arm-none-linux-gnueabihf- gcc needed (see arm-32 branch notes: ARM GNU toolchain tarball works too, put its bin/ on PATH)"; exit 1; fi
	$(A32_CC) $(GAS_CFLAGS) $(A32F) -S $< -o $@.raw && $(GAS_STRIP) < $@.raw > $@ && rm -f $@.raw
$(BUILD_DIR)/arm-32/%.o: $(BUILD_DIR)/arm-32/%.s | $(BUILD_DIR)/arm-32
	$(A32_AS) $(A32F) -o $@ $<
A32_OBJS = $(patsubst c_src/%.c,$(BUILD_DIR)/arm-32/%.o,$(wildcard c_src/*.c))
$(BIN_DIR)/arm-32/emerge: $(A32_OBJS) | $(BIN_DIR)/arm-32
	$(A32_CC) $(A32F) -Wl,-z,noexecstack -Wl,--as-needed -o $@ $(A32_OBJS) -latomic
	@echo "[+] armv7 hard-float binary built at $@ (v$(VERSION), $(if $(filter armv7l armv6l armv8l arm,$(HOST_ARCH)),native armv7,cross $(A32_TC)))"

# --------------------------------------------------------------- checks
check: $(BIN_DIR)/emerge
	@echo "[*] x86_64 smoke-test:"; file $(BIN_DIR)/emerge | cut -d: -f2-
	@if [ -n "$(filter x86_64,$(HOST_ARCH))$(Q64)" ]; then $(X64RUN) --version && $(X64RUN) --help >/dev/null && echo "[+] help ok"; else echo "[!] no qemu-x86_64 here — skipping run (build is OK)"; fi

check-all: x86_64 x86 arm arm-32
	@echo "[*] check x86_64:"   ; $(X64RUN)  --version
	@echo "[*] check i686:"     ; $(X86RUN)  --version
	@echo "[*] check aarch64:"  ; $(ARMRUN)  --version
	@echo "[*] check armv7:"    ; $(A32RUN)  --version
	@echo "[+] all targets run"

# ---- regeneratie: BOEM C -> obj -> objconv -> strip -> src/*.asm (byte-idem geverifieerd) ----
CC      := cc
UNIV_CFLAGS := -march=x86-64 -mtune=generic -O2 -pipe -fno-jump-tables

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

dist: $(BIN_DIR)/emerge
	mkdir -p $(DIST_DIR)
	tar -czf archtoo-v$(VERSION)-nasm-linux-x86_64.tar.gz $(SRC_DIR) $(HDR_DIR) Makefile README.md CHANGELOG.md LICENSE LICENSE.CKL
	@echo "[+] source archive built"

clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR) $(DIST_DIR)
	@echo "[+] Build directories cleaned"

# No sudo inside the recipe: run "sudo make install" yourself.
install: $(BIN_DIR)/emerge
	install -Dm755 $(BIN_DIR)/emerge $(DESTDIR)$(PREFIX)/bin/emerge
	@echo "[+] Installed to $(DESTDIR)$(PREFIX)/bin/emerge"

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/emerge
	@echo "[-] Removed $(DESTDIR)$(PREFIX)/bin/emerge"

.PHONY: native all x86_64 x86 arm arm-32 check check-all regen dist clean install uninstall
