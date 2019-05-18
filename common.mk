CLONEDIR?=$(HOME)/co

pvar-%:
	@echo $*=$($*)

SUDO?=sudo
IP?=/usr/local
PKG_CONFIG_PATH:=$(IP)/lib/pkgconfig/:$(PKG_CONFIG_PATH)
export PKG_CONFIG_PATH

SOURCE?=$(CLONEDIR)/$(PKG)-$(VER)
STOW_PREFIX?=$(IP)/stow/$(PKG)-$(VER)
APTPKG?=$(PKG)


$(IP)/bin/$(PKG): $(STOW_PREFIX)/bin/$(PKG)
	cd $(IP)/stow && $(SUDO) stow $(PKG)-$(VER)

$(STOW_PREFIX)/bin/$(PKG): $(SOURCE)/Makefile
	cd $(SOURCE) \
		&& make -j5 \
		&& $(SUDO) make install

%.tar.xz %.tar.gz. %tar.bz:
	wget $(URL) -O $@
	[ -f "$@" ] && touch $@

%/configure: %.tar.xz
	mkdir -p $(<D)
	tar xvf $< -C $(<D)
	[ -f "$@" ] && touch $@

%/configure: %.tar.gz
	cd $(@D) && tar xvf $<
	[ -f "$@" ] && touch $@

%/configure: %.tar.bz
	cd $(@D) && tar xvf $<
	[ -f "$@" ] && touch $@

%/Makefile: %/configure %-apt-dependencies
	cd $(@D) \
		&& chmod u+x ./configure \
		&& ./configure --prefix=$(STOW_PREFIX)
	[ -f "$@" ] && touch $@

$(SOURCE)-apt-dependencies:
	sudo apt-get build-dep $(APTPKG)
	touch $@
