INSTALLPREFIX=$HOME/.local
SRCDIR?=$HOME/co
TARBALL?=xclip-0.12.tar.gz
DIRKEY=xclip-0.12

$(INSTALLPREFIX)/bin/tree: $(SRCDIR)/$(DIRKEY)/Makefile
	cd $(@D) && \
	./configure --prefix=$(INSTALLPREFIX) && \
	$(MAKE) install

$(SRCDIR)/$(DIRKEY)/Makefile: $(SRCDIR)/$(TARBALL)
	tar xzf $<

$(SRCDIR)/$(TARBALL): $(SRCDIR)
	wget https://superb-sea2.dl.sourceforge.net/project/xclip/xclip/0.12/xclip-0.12.tar.gz $@

$(SRCDIR):
	mkdir -p $@
