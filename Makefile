CC          = gcc
CFLAGS      = -march=native -O3 -pipe -Wall -Wextra -Iheaders
UNIV_CFLAGS = -march=x86-64 -O2 -pipe -Wall -Wextra -Iheaders

SRC_DIR     = src
HDR_DIR     = headers
BUILD_DIR   = build
BIN_DIR     = bin
DIST_DIR    = dist

TARGET      = $(BIN_DIR)/emerge
DIST_BIN    = $(DIST_DIR)/emerge
DIST_ARCHIVE= $(DIST_DIR)/archtoo-v1.0.0-x86_64.tar.gz
PREFIX      = /usr/local/bin

SRCS        = $(SRC_DIR)/main.c \
              $(SRC_DIR)/utils.c \
              $(SRC_DIR)/world.c \
              $(SRC_DIR)/kernel.c \
              $(SRC_DIR)/unmerge.c \
              $(SRC_DIR)/build.c

OBJS        = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRCS))

all: $(TARGET)

$(BUILD_DIR) $(BIN_DIR) $(DIST_DIR):
	mkdir -p $@

# Native build voor lokaal gebruik (-march=native)
$(TARGET): $(OBJS) | $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $(OBJS)
	@echo "[+] Native binary gebouwd in $@"

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Universal build voor GitHub Release (.tar.gz)
dist: | $(DIST_DIR)
	$(CC) $(UNIV_CFLAGS) $(SRCS) -o $(DIST_BIN)
	tar -czvf $(DIST_ARCHIVE) -C $(DIST_DIR) emerge -C ../ LICENSE README.md
	rm -f $(DIST_BIN)
	@echo "[+] Release archief gebouwd in $(DIST_ARCHIVE)"

clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR) $(DIST_DIR)
	@echo "[+] Build mappen opgeruimd"

install: $(TARGET)
	sudo cp $(TARGET) $(PREFIX)/emerge
	sudo chmod 755 $(PREFIX)/emerge
	@echo "[+] Geïnstalleerd in $(PREFIX)/emerge"

uninstall:
	sudo rm -f $(PREFIX)/emerge
	@echo "[-] Verwijderd uit $(PREFIX)/emerge"

.PHONY: all clean install uninstall dist
