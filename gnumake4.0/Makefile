
SOURCE:=$(HOME)/co/make-4.1
INSTALL_PREFIX:=/usr/local

$(INSTALL_PREFIX)/bin/screen: $(SOURCE)/Makefile
	cd $(SOURCE) \
		&& make -j5 \
		&& sudo make install

$(SOURCE).tar.gz:
	wget http://ftp.gnu.org/gnu/make/make-4.1.tar.gz -O $@
	touch $@

$(SOURCE)/configure: $(SOURCE).tar.gz 
	cd $(dir $(SOURCE)) && tar xzvf $<
	touch $@

$(SOURCE)/Makefile: $(SOURCE)/configure $(SOURCE)/.apt-dependencies
	cd $(SOURCE) \
		&& ./configure --with-guile --prefix=$(INSTALL_PREFIX)
	touch $@

$(SOURCE)/.apt-dependencies: 
	sudo apt-get install build-essential guile-2.0-dev
	touch $@
