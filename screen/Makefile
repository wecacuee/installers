
SOURCE:=/aux/dhiman/co/screen-4.4.0
INSTALL_PREFIX:=$(HOME)/.local

$(INSTALL_PREFIX)/bin/screen: $(SOURCE)/Makefile
	cd $(SOURCE) \
		&& make -j5 \
		&& make install

$(SOURCE).tar.gz:
	wget http://ftp.gnu.org/gnu/screen/screen-4.4.0.tar.gz -O $@
	touch $@

$(SOURCE)/configure: $(SOURCE).tar.gz 
	cd $(dir $(SOURCE)) && tar xzvf $<
	touch $@

$(SOURCE)/Makefile: $(SOURCE)/configure $(SOURCE)/.apt-dependencies
	cd $(SOURCE) \
		&& ./configure --prefix=$(INSTALL_PREFIX)
	touch $@

$(SOURCE)/.apt-dependencies: 
	sudo apt-get install ncurses-dev texinfo
	touch $@
