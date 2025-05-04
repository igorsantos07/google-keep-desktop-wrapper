NEU_CONFIG := neutralino.config.json

APP_NAME := $(shell jq -r '.applicationId' $(NEU_CONFIG))
APP_TITLE := $(shell jq -r '.modes.window.title' $(NEU_CONFIG))
APP_CATEGORIES := Office;Utilities;
APP_DESCRIPTION := Google Keep (desktop wrapper)

BIN_FILE := $(shell jq -r '.cli.binaryName' $(NEU_CONFIG))
ICON_ORIGIN := $(shell jq -r '.modes.window.icon' $(NEU_CONFIG))
INSTALL_DIR := /opt/$(APP_NAME)
DIST_PATH := dist/$(BIN_FILE)
BIN_PATH := $(INSTALL_DIR)/$(BIN_FILE).bin
ICON_DEST := $(INSTALL_DIR)/icon.png
DESKTOP_FILE := ~/.local/share/applications/$(APP_NAME).desktop

.PHONY: install uninstall

install:
	# Create installation directory and copy files
	sudo install -d $(INSTALL_DIR)
	neu build
	sudo cp $(DIST_PATH)/$(BIN_FILE)-linux_x64 "$(BIN_PATH)"
	sudo cp ".$(ICON_ORIGIN)" "$(ICON_DEST)"
	sudo cp $(DIST_PATH)/resources.neu ./neutralino.config.json "$(INSTALL_DIR)"
	sudo chmod 755 "$(BIN_PATH)"
	# Set permissions for non-root users
	sudo chmod -R a+rX $(INSTALL_DIR)
	# Create desktop entry for current user
	@echo "[Desktop Entry]" > $(DESKTOP_FILE)
	@echo "Version=1.0" >> $(DESKTOP_FILE)
	@echo "Type=Application" >> $(DESKTOP_FILE)
	@echo "Name=$(APP_TITLE)" >> $(DESKTOP_FILE)
	@echo "Exec=$(BIN_PATH)" >> $(DESKTOP_FILE)
	@echo "Icon=$(ICON_DEST)" >> $(DESKTOP_FILE)
	@echo "Categories=$(APP_CATEGORIES)" >> $(DESKTOP_FILE)
	@echo "Comment=$(APP_DESCRIPTION)" >> $(DESKTOP_FILE)
	@echo "Terminal=false" >> $(DESKTOP_FILE)
	chmod 644 $(DESKTOP_FILE)

uninstall:
	sudo rm -rf $(INSTALL_DIR)
	rm -f $(DESKTOP_FILE)

