VERSION=2.3.1
IP?=/z/sw/packages/singularity/$(VERSION)
BUILD?=$(HOME)/co/singularity/$(VERSION)

all: $(IP)/singularity

$(BUILD)/singularity-$(VERSION).tar.gz: $(BUILD)/.mkdir
	wget https://github.com/singularityware/singularity/releases/download/$(VERSION)/singularity-$(VERSION).tar.gz -O $@

$(BUILD)/singularity-$(VERSION)/configure: $(BUILD)/singularity-$(VERSION).tar.gz
	tar xvf singularity-$(VERSION).tar.gz

$(BUILD)/singularity-$(VERSION)/Makefile: $(BUILD)/singularity-$(VERSION)/configure
	cd singularity-$(VERSION) \
		&& ./configure --prefix=$(IP)

$(IP)/singularity: $(BUILD)/singularity-$(VERSION)/Makefile
	cd singularity-$(VERSION) \
		&& $(MAKE) \
		&& $(MAKE) install

%/.mkdir:
	mkdir -p $(@D)
	touch $@
