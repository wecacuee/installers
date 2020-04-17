#!/usr/bin/make -f
SHELL=/bin/bash -l
ROOT_DIR?=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

UNISON_VERSION?=2.48.15v4
SOURCE_PREFIX?=$(HOME)/.local/src/
INSTALL_PREFIX?=/usr/local/
STOW_PREFIX?=$(INSTALL_PREFIX)/stow

UNISON_DIR?=$(SOURCE_PREFIX)/unison-$(UNISON_VERSION)
UNISON_INSTALL_DIR?=$(STOW_PREFIX)/unison-$(UNISON_VERSION)
UNISON_INSTALLED?=$(UNISON_INSTALL_DIR)/bin/unison
UNISON_STOWED?=$(INSTALL_PREFIX)/bin/unison

unison: $(UNISON_STOWED)

$(UNISON_STOWED): $(UNISON_INSTALLED)
	sudo stow --dir=$(STOW_PREFIX) --target=$(INSTALL_PREFIX) unison-$(UNISON_VERSION)

$(UNISON_INSTALLED): $(UNISON_DIR)/Makefile
	eval $$(opam env) && \
		make -C $(<D) STATIC=true NATIVE=true && \
		sudo mkdir -p $(@D) && \
		sudo mv $(<D)/src/unison $(@)


$(UNISON_DIR)/Makefile: /home/vdhiman/.opam/4.08.0/bin/ocaml
	-mkdir -p $(dir $(UNISON_DIR))
	curl -sL https://github.com/bcpierce00/unison/archive/v2.48.15v4.tar.gz | tar -C $(dir $(UNISON_DIR)) -xzf -
	touch $@

/home/vdhiman/.opam/4.08.0/bin/ocaml: /usr/local/bin/opam
	eval $(opam env) && \
	opam switch create 4.08.0

/usr/local/bin/opam:
	sudo bash -c "sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
	echo "ny" | opam init
