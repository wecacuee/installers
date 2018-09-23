IP=/usr/local
SP=$(HOME)/co
MD=/z/sw/Modules/default/modulefiles
PKG=modules-4.1.2
URL=https://sourceforge.net/projects/modules/files/Modules/modules-4.1.2/modules-4.1.2.tar.gz/download
ENDFILE=$(IP)/bin/modulecmd

$(ENDFILE):$(SP)/$(PKG)/Makefile
	$(SUDO) make -C $(<D) install

$(SP)/$(PKG).tar.gz:
	wget $(URL) -O $@
	touch $@

$(SP)/$(PKG)/configure: $(SP)/$(PKG).tar.gz
	tar xvf $< -C $(dir $(@D))
	touch $@

$(SP)/$(PKG)/Makefile:$(SP)/$(PKG)/configure
	cd $(@D) && ./configure --prefix=$(IP) --modulefilesdir=$(MD)
