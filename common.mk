ifndef COMMON_MK
COMMON_MK:=1

CLONEDIR?=$(HOME)/Downloads/

pvar-%:
	@echo $($*)

SUDO?=sudo
IP?=/usr/local
PKG_CONFIG_PATH:=$(IP)/lib/pkgconfig/:$(PKG_CONFIG_PATH)
export PKG_CONFIG_PATH

SOURCE?=$(CLONEDIR)/$(PKG)-$(VER)
STOW_PREFIX?=$(IP)/stow/$(PKG)-$(VER)
APTPKG?=$(PKG)


$(IP)/bin/$(PKG): $(STOW_PREFIX)/bin/$(PKG)
	cd $(IP)/stow && $(SUDO) stow $(PKG)-$(VER)

$(SOURCE)-apt-dependencies:
	sudo apt-get build-dep $(APTPKG)
	touch $@

endif # COMMON_MK
