VERSION = 3.0.0
NASM   ?= nasm
CC     ?= gcc
NASM_FLAGS = -f elf64 -w+all
SRC_DIR   = src
BUILD_DIR = build
BIN_DIR   = bin
DIST_DIR  = dist
TARGET    = $(BIN_DIR)/emerge
SRCS = $(wildcard $(SRC_DIR)/*.asm)
OBJS = $(patsubst $(SRC_DIR)/%.asm,$(BUILD_DIR)/%.o,$(SRCS))
all: $(TARGET)
$(BUILD_DIR) $(BIN_DIR) $(DIST_DIR):
	mkdir -p $@
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	@echo "[NASM] nasm -f elf64 -o $@ $<"
	@$(NASM) $(NASM_FLAGS) -o $@ $<
$(TARGET): $(OBJS) | $(BIN_DIR)
	@echo "[LD] $(CC) -o $@ $(OBJS) -lc -lm"
	@$(CC) -o $@ $(OBJS) -lc -lm
	@echo "[+] Pure NASM binary built at $@"
	@ls -lh $@
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR) $(DIST_DIR)
install: $(TARGET)
	install -Dm755 $(TARGET) $(DESTDIR)$(PREFIX)/bin/emerge
.PHONY: all clean install
