ifndef COMMON_CONFIG_MK
COMMON_CONFIG_MK:=1

include common.mk

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
		&& ./configure --prefix=$(STOW_PREFIX) $(CONFIGOPTS)
	[ -f "$@" ] && touch $@

%/Makefile: %/configure %-apt-dependencies
	cd $(@D) \
		&& chmod u+x ./configure \
		&& ./configure --prefix=$(STOW_PREFIX) $(CONFIGOPTS)
	[ -f "$@" ] && touch $@

endif # COMMON_CONFIG_MK
