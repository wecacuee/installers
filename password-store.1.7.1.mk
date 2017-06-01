INSTALLPREFIX=$HOME/.local
SRCDIR?=$HOME/co
TARBALL?=password-store-1.7.1.tar.xz

include tree-1.7.0.mk
include xclip-0.12.mk

$(INSTALLPREFIX)/bin/pass: $(SRCDIR)/password-store-1.7.1/Makefile $(INSTALLPREFIX)/bin/tree $(INSTALLPREFIX)/bin/xclip
	cd $(@D) && \
	$(MAKE) PREFIX=$(INSTALLPREFIX) install

$(SRCDIR)/password-store-1.7.1/Makefile: $(SRCDIR)/$(TARBALL)
	tar xzf $<

$(SRCDIR)/$(TARBALL): $(SRCDIR)
	wget https://git.zx2c4.com/password-store/snapshot/password-store-1.7.1.tar.xz $@

$(SRCDIR):
	mkdir -p $@
