IP=/usr/local
SP=$(HOME)/co/

$(IP)/bin/modulecmd:$(SP)/Lmod-7.7/Makefile
	$(SUDO) make -C $(<D) install

$(SP)/Lmod-7.7.tar.bz2:
	wget https://ayera.dl.sourceforge.net/project/lmod/Lmod-7.7.tar.bz2 -O $@

$(SP)/Lmod-7.7/configure: $(SP)/Lmod-7.7.tar.bz2
	tar xvf $< -C $(dir $(@D))

$(SP)/Lmod-7.7/Makefile:$(SP)/Lmod-7.7/configure
	cd $(@D) && ./configure --prefix=$(IP)
