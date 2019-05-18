VER:=4.0.1
SOURCE:=$(HOME)/co/openmpi-$(VER)
INSTALL_PREFIX:=/usr/local/stow/openmpi-$(VER)

$(INSTALL_PREFIX)/bin/mpirun: $(SOURCE)/Makefile
	cd $(SOURCE) \
		&& make -j5 \
		&& sudo make install

%.tar.bz2:
	wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.1.tar.bz2 -O $@
	[ -f "$@" ] && touch $@

%/configure: %.tar.bz2
	mkdir -p $(<D)
	tar xvf $< -C $(<D)
	[ -f "$@" ] && touch $@

%/Makefile: %/configure %-apt-dependencies
	cd $(@D) \
		&& chmod u+x ./configure \
		&& ./configure --prefix=$(INSTALL_PREFIX)
	[ -f "$@" ] && touch $@

$(SOURCE)-apt-dependencies: 
	sudo apt-get build-dep libopenmpi-dev
	touch $@
