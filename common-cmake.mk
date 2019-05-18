ifndef COMMON_CMAKE_MK
COMMON_CMAKE_MK:=1

include common.mk

$(STOW_PREFIX)/bin/$(PKG): $(SOURCE)/build/Makefile
	cd $(<D) \
		&& make -j5 \
		&& $(SUDO) make install

%/CMakeLists.txt: %.tar.gz
	tar xvf $< -C $(<D)
	[ -f "$@" ] && touch $@

%/CMakeLists.txt: %.tar.bz
	tar xvf $< -C $(<D)
	[ -f "$@" ] && touch $@

%/CMakeLists.txt: %.tar.xz
	tar xvf $< -C $(<D)
	[ -f "$@" ] && touch $@

%/build/Makefile: %/CMakeLists.txt %-apt-dependencies
	mkdir -p $(@D)
	cd $(@D) \
		&& cmake .. -DCMAKE_INSTALL_PREFIX=$(STOW_PREFIX) $(CONFIGOPTS)
	[ -f "$@" ] && touch $@

endif # COMMON_CMAKE_MK
