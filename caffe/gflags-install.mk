ROOT_DIR?=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
INSTALL_PREFIX?=$(HOME)/co
SOURCE_PREFIX?=$(HOME)/co
GFLAGS_VER?=2.2.1

GFLAGS_DIR?=$(SOURCE_PREFIX)/gflags
GFLAGS_INSTALL_DIR?=$(GFLAGS_DIR)/install/
GFLAGS_INSTALLED?=$(GFLAGS_INSTALL_DIR)/include/gflags/gflags.h

$(GFLAGS_DIR)/CMakeLists.txt: 
	cd $(dir $(GFLAGS_DIR)) && \
		git clone https://github.com/gflags/gflags.git $(GFLAGS_DIR)
	cd $(GFLAGS_DIR) && git checkout v$(GFLAGS_VER)
	touch $@

$(GFLAGS_DIR)/build/Makefile: $(GFLAGS_DIR)/CMakeLists.txt
	cd  $(GFLAGS_DIR) && mkdir -p build && cd build && cmake .. \
		-DCMAKE_INSTALL_PREFIX=$(GFLAGS_INSTALL_DIR)/ \
		-DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=OFF -DBUILD_PACKAGING=OFF \
		-DBUILD_TESTING=OFF -DBUILD_NC_TESTS=OFF -DBUILD_CONFIG_TESTS=OFF \
		-DINSTALL_HEADERS=ON  \
		-DCUDA_TOOLKIT_ROOT_DIR=$(CUDA_TOOLKIT_ROOT_DIR)

.PHONY: gflags
gflags: $(GFLAGS_INSTALLED)
$(GFLAGS_INSTALLED): $(GFLAGS_DIR)/build/Makefile
	cd $(GFLAGS_DIR)/build && make install
	touch $@
