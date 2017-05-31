
SOURCE:=$(HOME)/co/emacs-24.5
INSTALL_PREFIX:=/usr/local

$(INSTALL_PREFIX)/bin/emacs: $(SOURCE)/Makefile
	cd $(SOURCE) \
		&& make -j5 \
		&& sudo make install

%.tar.xz:
	wget https://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.xz -O $@
	touch $@

%/configure: %.tar.xz 
	cd $(@D) && tar xvf $<
	touch $@

%/configure: %.tar.gz 
	cd $(@D) && tar xvf $<
	touch $@

%/Makefile: %/configure %/.apt-dependencies
	cd $(@D) \
		&& ./configure --prefix=$(INSTALL_PREFIX)
	touch $@

$(SOURCE)/.apt-dependencies: 
	sudo apt-get build-dep emacs24
	touch $@
