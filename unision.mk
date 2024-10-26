#!/usr/bin/make -f
SHELL=/bin/bash -l
ROOT_DIR?=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

SUDO?=sudo
UNISON_VERSION?=2.51.5
SOURCE_PREFIX?=$(HOME)/.local/src/
INSTALL_PREFIX?=$(HOME)/.local/

UNISON_DIR?=$(SOURCE_PREFIX)/unison-$(UNISON_VERSION)
UNISON_INSTALL_DIR?=$(INSTALL_PREFIX)
UNISON_INSTALLED?=$(UNISON_INSTALL_DIR)/bin/unison

unison: $(UNISON_INSTALLED)

$(UNISON_INSTALLED): $(UNISON_DIR)/bin/unison
	eval $$(opam env --switch=default) && \
		mkdir -p $(@D) && \
		$(SUDO) cp $< $@


URL:=https://github.com/bcpierce00/unison/releases/download/v2.51.4/unison-v2.51.4+ocaml-4.12.0+x86_64.linux.tar.gz
$(UNISON_DIR)/bin/unison:  $(HOME)/.opam/default/bin/ocaml
	-mkdir -p $(UNISON_DIR)
	curl -sL $(URL) | tar -C $(UNISON_DIR) -xzf -
	touch $@

$(HOME)/.opam/default/bin/ocaml: /usr/local/bin/opam
	eval $$(opam env) #&& \
	#opam switch create 4.12.0

/usr/local/bin/opam:
	bash -c "sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
	echo "ny" | opam init
