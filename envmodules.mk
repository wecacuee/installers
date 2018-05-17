IP=/usr/local
SP=$(HOME)/co/
PKG=modules-4.1.2
URL=https://sourceforge.net/projects/modules/files/Modules/modules-4.1.2/modules-4.1.2.tar.gz/download
ENDFILE=$(IP)/bin/modulecmd

$(ENDFILE):$(SP)/$(PKG)/Makefile
	$(SUDO) make -C $(<D) install

$(SP)/$(PKG).tar.gz:
	wget $(URL) -O $@

$(SP)/$(PKG)/configure: $(SP)/$(PKG).tar.gz
	tar xvf $< -C $(dir $(@D))

$(SP)/$(PKG)/Makefile:$(SP)/$(PKG)/configure
	cd $(@D) && ./configure --prefix=$(IP)
