INSTALLPREFIX=$HOME/.local
SRCDIR?=$HOME/co
TARBALL?=tree-1.7.0.tgz
DIRKEY=tree-1.7.0

$(INSTALLPREFIX)/bin/tree: $(SRCDIR)/$(DIRKEY)/Makefile
	cd $(@D) && \
	$(MAKE) prefix=$(INSTALLPREFIX) install

$(SRCDIR)/$(DIRKEY)/Makefile: $(SRCDIR)/$(TARBALL)
	tar xzf $<

$(SRCDIR)/$(TARBALL): $(SRCDIR)
	wget ftp://mama.indstate.edu/linux/tree/tree-1.7.0.tgz $@

$(SRCDIR):
	mkdir -p $@
