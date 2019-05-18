#!/usr/bin/make -f

PKG?=languagetool
VER?=4.5
GITSRC?=https://github.com/languagetool-org/languagetool.git
INSTALL_PREFIX?=$(HOME)/co/$(PKG)
SRC_PREFIX?=$(HOME)/co/
INSTALL_TARGET?=$(INSTALL_PREFIX)/lib/languagetool/languagetool-commandline.jar
CO_TARGET?=$(SRC_PREFIX)/$(PKG)/build.sh
BUILD_TARGET?=$(SRC_PREFIX)/$(PKG)/
all: $(INSTALL_TARGET)

$(INSTALL_TARGET): $(BUILD_TARGET)
	$(MAKE) install -C $(<D)
	rm -rf $(NAME)

$(BUILD_TARGET): $(CO_TARGET)
	./$< language-commandline check package

$(CO_TARGET):
	git clone $(GITSRC) $(@D)
	git tag v$(VER)
