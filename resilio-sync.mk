
URL:=https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz
PKG:=resilio-sync_x64
SOURCE:=$(HOME)/co/$(PKG)
INSTALL_PREFIX:=/usr/local
STOW_PREFIX:=$(INSTALL_PREFIX)/stow/$(PKG)

$(INSTALL_PREFIX)/bin/rslsync: $(STOW_PREFIX)/bin/rslsync
	cd $(dir $(STOW_PREFIX)) && sudo stow $(PKG)

$(STOW_PREFIX)/bin/rslsync: $(SOURCE)/rslsync
	sudo mkdir -p $(@D)
	sudo install $< $@

$(SOURCE)/rslsync: $(dir SOURCE)/$(PKG).tar.gz
	mkdir -p $(@D)
	tar xvf $< -C $(@D)
	[ -f "$@" ] && touch $@

%.tar.gz:
	wget $(URL) -O $@
	[ -f "$@" ] && touch $@
