CWD:=$(dir $(lastname $(MAKEFILE_LIST)))

include $(CWD)/apt-source-install.mk 


$(CO)/.configure-openssl.stamp: $(CO)/.source-openssl.stamp
	cd $(CO)/openssl/openssl/ && \
		./Configure --prefix=$(IP) debian-amd64 && \
		make depend
