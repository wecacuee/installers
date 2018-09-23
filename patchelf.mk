#!/usr/bin/make -f

NAME=/tmp/patchelf-0.9
all: /usr/local/bin/patchelf

/usr/local/bin/patchelf: $(NAME)/Makefile $(NAME)/src/patchelf
	sudo $(MAKE) install -C $(<D)
	rm -rf $(NAME)

$(NAME)/src/patchelf: $(NAME)/Makefile
	$(MAKE) -C $(<D)

%/Makefile: %/configure
	cd $(<D) && ./$(<F)

CONF=$(NAME)/configure
TAR=/tmp/patchelf-0.9.tar.gz
$(CONF): $(TAR)
	tar xzvf $(TAR) -C $(or $(dir $(NAME)),./)
	touch $@

$(TAR):
	wget https://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.gz -O $@
