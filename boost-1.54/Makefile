
SOURCE:=$(HOME)/co/boost_1_54_0
INSTALL_PREFIX:=$(SOURCE)/install

$(INSTALL_PREFIX)/lib/libboost_python.so: $(SOURCE)/b2
	cd $(SOURCE) \
		&& ./b2 install

$(SOURCE).tar.gz:
	wget http://sourceforge.net/projects/boost/files/boost/1.54.0/boost_1_54_0.tar.gz -O $@
	touch $@

$(SOURCE)/bootstrap.sh: $(SOURCE).tar.gz 
	cd $(dir $(SOURCE)) && tar xzvf $<
	touch $@

ifflux:=$(findstring arc-ts,$(shell hostname))

$(SOURCE)/b2: $(SOURCE)/configure \
	$(if $(ifflux), $(SOURCE)/.module-dependencies, $(SOURCE)/.apt-dependencies)
	cd $(SOURCE) \
		&& ./bootstrap.sh --prefix=$(INSTALL_PREFIX)
	touch $@

$(SOURCE)/.module-dependencies:

$(SOURCE)/.apt-dependencies: 
	sudo apt-get install ncurses-dev texinfo
	touch $@
