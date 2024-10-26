#!/usr/bin/make -f

IP?=/usr/local
PKG:=neovide
APTPKG:=neovide
VER:=0.10.3
URL:=https://github.com/neovide/neovide/releases/download/0.10.3/neovide.tar.gz
GITURL:=https://github.com/neovide/neovide.git


all: $(IP)/share/applications/$(PKG).desktop

include common.mk

BINARYTAR:=$(SOURCE)/bin/neovide.tar.gz
BINARY:=$(SOURCE)/bin/neovide

$(STOW_PREFIX)/bin/$(PKG): $(BINARY)
	$(SUDO) mkdir -p $(@D)
	$(SUDO) install $< $@

ICONSTOWDIR:=$(STOW_PREFIX)/share/icons/hicolor
ICONPNGASSETS=$(wildcard $(SOURCE)/assets/$(PKG)-*.png)
ICONPNGSRC2INSTALL=$(shell echo "$(subst $(SOURCE)/assets,$(ICONSTOWDIR),$(1))" | sed -e 's!$(PKG)-\([0-9x]*\).png!\1/apps/$(PKG).png!')
ICONFILESPNG_EG=$(call ICONPNGSRC2INSTALL,/usr/local/stow/neovide-0.10.3/share/icons/hicolor/neovide-16x16.png)
ICONFILESPNG=$(foreach icon, \
	$(ICONPNGASSETS), \
	$(call ICONPNGSRC2INSTALL,$(icon)))
ICON_SCA_ASSETS=$(wildcard $(SOURCE)/assets/$(PKG).svg) $(wildcard $(SOURCE)/assets/$(PKG).ico)
ICON_SCA_SRC2INSTALL=$(patsubst $(SOURCE)/assets/$(PKG).%,$(ICONSTOWDIR)/scalable/apps/$(PKG).%,$(1))
ICONFILES_SCALABLE=$(foreach icon,  \
	$(ICON_SCA_ASSETS), \
	$(call ICON_SCA_SRC2INSTALL,$(icon)))

FONT_INSTALL_DIR=$(HOME)/.fonts/opentype
## wont work because there are spaces in the files
# FONT_FILE_ASSETS=$(wildcard $(SOURCE)/assets/fonts/*.otf) $(wildcard $(SOURCE)/assets/fonts/*.ttf)
# FONT_FILE_SRC2INSTALL=$(subst $(SOURCE)/assets/fonts,$(FONT_INSTALL_DIR),$(1))
# FONT_FILES=$(foreach font,$(FONT_FILE_ASSETS), \
# 		 $(call FONT_FILE_SRC2INSTALL,$(font)))
FONT_FILES=$(FONT_INSTALL_DIR)/.SOURCE
$(STOW_PREFIX)/share/applications/$(PKG).desktop: \
	$(SOURCE)/assets/neovide.desktop \
	$(ICONFILESPNG) \
	$(ICONFILES_SCALABLE) \
	$(FONT_FILES)
	$(SUDO) mkdir -p $(@D)
	$(SUDO) install $< $@

$(IP)/share/applications/$(PKG).desktop: $(STOW_PREFIX)/share/applications/$(PKG).desktop
	cd $(IP)/stow && $(SUDO) stow $(PKG)-$(VER)


$(FONT_FILES): $(SOURCE)/assets/fonts/FiraCodeNerdFont-Regular.ttf
	mkdir -p $(FONT_INSTALL_DIR)
	cp $(SOURCE)/assets/fonts/* $(@D)
	echo "$(SOURCE)/assets/fonts/*" > $@ 

# $(FONT_INSTALL_DIR)/%.otf: $(SOURCE)/assets/fonts/%.otf
# 	mkdir -p $(@D)
# 	cp $< $@
# 
# $(FONT_INSTALL_DIR)/%.ttf: $(SOURCE)/assets/fonts/%.ttf
# 	mkdir -p $(@D)
# 	cp $< $@

$(ICONSTOWDIR)/%/apps/$(PKG).png: $(SOURCE)/assets/$(PKG)-%.png
	$(SUDO) mkdir -p $(@D)
	$(SUDO) install $< $@
$(ICONSTOWDIR)/scalable/apps/$(PKG).svg: $(SOURCE)/assets/$(PKG).svg
	$(SUDO) mkdir -p $(@D)
	$(SUDO) install $< $@
$(ICONSTOWDIR)/scalable/apps/$(PKG).ico: $(SOURCE)/assets/$(PKG).ico
	$(SUDO) mkdir -p $(@D)
	$(SUDO) install $< $@

$(SOURCE)/assets/$(PKG).desktop: $(SOURCE)/.git/config

$(SOURCE)/.git/config:
	git clone $(GITURL) $(SOURCE)

$(SOURCE)/bin/$(PKG): $(SOURCE)/bin/$(PKG).tar.gz
	tar --directory=$(<D) -xzvf $<

$(SOURCE)/bin/$(PKG).tar.gz:
	mkdir -p $(SOURCE)/bin/
	wget $(URL) -O $(SOURCE)/bin/$(@F)
	[ -f "$@" ] && touch $@


