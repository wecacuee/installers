CD:=$(dir $(realpath $(lastword $(MAKEFILE_LIST))))

IP:=$(CD)/installprefix

wxwidgets-install:=$(IP)/wxWidgets/

kicadsrc-cmake:=kicad/CMakeLists.txt
kicadsrc-make:=kicad/build/Makefile
$(kicadsrc-make): $(kicadsrc-cmake) $(wxwidgets-install)
	mkdir -p $(@D)
	cd $(@D) && \
	cmake .. -DKICAD_STABLE_VERSION=On -DCMAKE_INSTALL_PREFIX=$(IP)

$(kicadsrc-cmake):
	apt-get source kicad
	ln -sT $(shell ls -d kicad-*) $(@D)

wxwidgets-make:=wxWidgets/Makefile
wxwidgets-config:=wxWidgets/configure
$(wxwidgets-install): $(wxwidgets-make)
	cd $(<D) && \
	make -j install

$(wxwidgets-make): $(wxwidgets-config)
	cd $(<D) && \
	./configure --prefix=$(IP)

$(wxwidgets-config):
	apt-get source wxwidgets3.0
	ln -sT $(shell ls -d wxwidgets3.0-*) $(@D)

freelibs:=freetronics_kicad_library/README.md
$(freelibs):
	git clone https://github.com/freetronics/freetronics_kicad_library.git
	touch $@
