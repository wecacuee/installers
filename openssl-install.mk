CWD:=$(dir $(lastword $(MAKEFILE_LIST)))

openssl: $(HOME)/co/.install-openssl.stamp
	@true

include $(CWD)/apt-source-install.mk 


$(CO)/.install-openssl.stamp: $(CO)/.configure-openssl.stamp
	cd $(CO)/openssl/openssl/ && \
	sed -ie 's#MANDIR=/usr/share#MANDIR=$(IP)/share#' Makefile && \
	$(MAKE) install
	touch $@

$(CO)/.configure-openssl.stamp: $(CO)/.source-openssl.stamp
	cd $(CO)/openssl/openssl/ && \
		./config --shared --prefix=$(IP) --openssldir=$(IP)/openssl/ && \
		make depend
	touch $@
