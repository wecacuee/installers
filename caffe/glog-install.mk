ROOT_DIR?=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
INSTALL_PREFIX?=$(HOME)/co
SOURCE_PREFIX?=$(HOME)/co

GLOG_INSTALL_DIR?=$(INSTALL_PREFIX)/glog/install/
GLOG_INSTALLED?=$(GLOG_INSTALL_DIR)/include/glog/logging.h
GLOG_DIR?=$(SOURCE_PREFIX)/glog

$(GLOG_DIR)/configure:
	cd $(dir $(GLOG_DIR)) && \
		git clone https://github.com/google/glog $(GLOG_DIR)
	cd $(GLOG_DIR) && git checkout v0.3.5
	touch $@

-include gflags-install.mk
$(GLOG_DIR)/Makefile: $(GLOG_DIR)/configure $(GFLAGS_INSTALLED)
	cd $(GLOG_DIR) && ./configure --prefix=$(GLOG_INSTALL_DIR)/ --enable-shared=yes --enable-static=no --with-gflags=$(GFLAGS_INSTALL_DIR)/lib/..

.PHONY: glog
glog: $(GLOG_INSTALLED)
$(GLOG_INSTALLED): $(GLOG_DIR)/Makefile
	cd $(GLOG_DIR) && make install
	touch $@

