#!/usr/bin/make -f

VER:=26.2
SOURCE:=$(HOME)/co/emacs-$(VER)
INSTALL_PREFIX:=/usr/local/stow/emacs-$(VER)

/usr/local/bin/emacs: $(INSTALL_PREFIX)/bin/emacs
	cd /usr/local/stow && sudo stow emacs-$(VER)

$(INSTALL_PREFIX)/bin/emacs: $(SOURCE)/Makefile
	cd $(SOURCE) \
		&& make -j5 \
		&& sudo make install

%.tar.xz:
	wget https://ftp.gnu.org/gnu/emacs/emacs-$(VER).tar.xz -O $@
	[ -f "$@" ] && touch $@

%/configure: %.tar.xz
	mkdir -p $(<D)
	tar xvf $< -C $(<D)
	[ -f "$@" ] && touch $@

%/configure: %.tar.gz 
	cd $(@D) && tar xvf $<
	[ -f "$@" ] && touch $@

%/Makefile: %/configure #%-apt-dependencies
	cd $(@D) \
		&& chmod u+x ./configure \
		&& ./configure --prefix=$(INSTALL_PREFIX)
	[ -f "$@" ] && touch $@

$(SOURCE)-apt-dependencies: 
	sudo apt-get build-dep emacs24
	touch $@
