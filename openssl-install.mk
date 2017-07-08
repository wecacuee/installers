CWD:=$(dir $(lastname $(MAKEFILE_LIST)))

include $(CWD)/apt-source-install.mk 


$(CO)/.configure-openssl.stamp: $(CO)/.source-openssl.stamp
	cd $(CO)/openssl/openssl/ && \
		./Configure debian-amd64 --prefix=$(IP) && \
		make depend
