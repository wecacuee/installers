VERSION=2.3.1
WGET:=wget
IP?=/z/sw/packages/singularity/$(VERSION)

all: $(IP)/singularity

singularity-$(VERSION).tar.gz: 
	$(WGET) https://github.com/singularityware/singularity/releases/download/$(VERSION)/singularity-$(VERSION).tar.gz -O $@

singularity-$(VERSION)/configure: singularity-$(VERSION).tar.gz
	tar xvf singularity-$(VERSION).tar.gz

singularity-$(VERSION)/Makefile: singularity-$(VERSION)/configure
	cd singularity-$(VERSION) \
		&& ./configure --prefix=$(IP)

$(IP)/singularity: singularity-$(VERSION)/Makefile
	cd singularity-$(VERSION) \
		&& $(MAKE) \
		&& $(MAKE) install
