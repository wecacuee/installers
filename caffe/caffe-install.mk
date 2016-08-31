ROOT_DIR?=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
INSTALL_PREFIX?=$(HOME)/co
SOURCE_PREFIX?=$(HOME)/co

CAFFE_DIR?=$(SOURCE_PREFIX)/caffe
CAFFE_INSTALL_DIR?=$(CAFFE_DIR)/install
CAFFE_INSTALLED?=$(CAFFE_INSTALL_DIR)/lib/libcaffe.so

caffe: $(CAFFE_INSTALLED)
$(CAFFE_INSTALLED): $(CAFFE_DIR)/build/Makefile
	$(MAKE) -C $(dir $<) install
	touch $@

$(CAFFE_DIR)/CMakeLists.txt:
	mkdir -p $(dir $(CAFFE_DIR))
	cd $(dir $(CAFFE_DIR)) && git clone https://github.com/BVLC/caffe.git $(notdir $(CAFFE_DIR))
	git checkout rc3
	#git checkout 64314779c040f0148cc8a3700d27fa8be9017198

$(CAFFE_DIR)/.patched:
	cd $(CAFFE_DIR) && patch -p1 < $(ROOT_DIR)/caffe.rc3.patch


-include utils.mk
-include gflags-install.mk
-include glog-install.mk
-include opencv-install.mk
-include cuda-install.mk
-include boost-install.mk

$(CAFFE_DIR)/build/Makefile: $(CAFFE_DIR)/CMakeLists.txt \
	$(CAFFE_DIR)/.patched \
	$(CAFFE_DIR)/.sys-dependencies
	-mkdir -p $(CAFFE_DIR)/build
	cd $(CAFFE_DIR)/build \
		&& . $(CAFFE_DIR)/.sys-dependencies \
		&& cmake .. -DCMAKE_INSTALL_PREFIX=$(CAFFE_INSTALL_DIR) \
		-DUSE_OPENCV=On -DOpenCV_DIR=$(OPENCV_INSTALL_DIR)/share/OpenCV \
		-DCUDNN_ROOT=$${CUDNN_ROOT}/include\;$${CUDNN_ROOT}/lib64 \
		-DCUDA_TOOLKIT_ROOT_DIR=$${CUDA_ROOT}/targets/x86_64-linux/ \
		$(if $(isflux), -DBOOST_ROOT=$${BOOST_ROOT}, ) \
		$(if $(isflux), -DBLAS=MKL, ) \
		$(if $(isflux), -DPROTOBUF_PROTOC_EXECUTABLE=/usr/bin/protoc -DPROTOBUF_INCLUDE_DIR=/usr/include , ) 
		

$(CAFFE_DIR)/.sys-dependencies: $(if $(isflux), $(OPENCV_INSTALLED), $(OPENCV_INSTALLED) $(CUDA_INSTALLED) $(CUDNN_INSTALLED) $(GLOG_INSTALLED) $(GFLAGS_INSTALLED))
ifeq ($(isflux),arc-ts)
	echo "module load gcc/4.8.5 intel-tbb hdf5/1.8.16/gcc/4.8.5 mkl boost python-dev cuda/7.5 cudnn/7.0-v4; export MKL_ROOT=$${MKLROOT}" > $@
else
	sudo apt-get install libboost-system-dev libboost-thread-dev libboost-filesystem-dev libboost-python-dev libprotobuf-dev libhdf5-dev liblmdb-dev libleveldb-dev libsnappy-dev libatlas3-base libatlas-base-dev python-numpy doxygen
	echo "export CUDA_BIN_PATH=$(CUDA_TOOLKIT_ROOT_DIR)/bin/ CUDA_ROOT=$(CUDA_TOOLKIT_ROOT_DIR) CUDNN_ROOT=$(CUDNN_ROOT)" > $@
endif

