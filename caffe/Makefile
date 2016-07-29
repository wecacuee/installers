ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
INSTALL_PREFIX=$(HOME)/co
SOURCE_PREFIX=$(HOME)/co

CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-7.0
CUDA_PATH:=$(CUDA_TOOLKIT_ROOT_DIR)/:$(CUDA_TOOLKIT_ROOT_DIR)/targets/x86_64-linux/:$(CUDA_PATH)
export CUDA_PATH
CXX_INCLUDE_PATH:=$(CUDA_TOOLKIT_ROOT_DIR)/include/:$(CUDA_TOOLKIT_ROOT_DIR)/targets/x86_64-linux/include/:$(CXX_INCLUDE_PATH)
GFLAGS_INSTALL_DIR:=$(INSTALL_PREFIX)/gflags/install/
GLOG_INSTALL_DIR:=$(INSTALL_PREFIX)/glog/install/
GLOG_DIR:=$(SOURCE_PREFIX)/glog
GFLAGS_DIR:=$(SOURCE_PREFIX)/gflags

.PHONY: all caffe opencv2
all: caffe opencv2

CUDA_INSTALLED:=$(CUDA_TOOLKIT_ROOT_DIR)/targets/x86_64-linux/lib/libcudart.so
CUDNN_INSTALLED:=$(CUDA_TOOLKIT_ROOT_DIR)/lib64/libcudnn.so
CUDNN_ROOT:=$(CUDA_TOOLKIT_ROOT_DIR)

OPENCV_VERSION=2.4.13
OPENCV3_DIR=$(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION)
OPENCV3_INSTALL_DIR:=$(INSTALL_PREFIX)/opencv-$(OPENCV_VERSION)/install
opencv2: $(OPENCV3_INSTALL_DIR)/lib/libopencv_core.so
$(OPENCV3_INSTALL_DIR)/lib/libopencv_core.so: $(OPENCV3_DIR)/build/Makefile
	$(MAKE) -C $(dir $<) install

$(OPENCV3_DIR)/build/Makefile: $(OPENCV3_DIR)/CMakeLists.txt \
	$(OPENCV3_DIR)/.apt-dependencies \
	$(CUDA_INSTALLED)
	-mkdir -p $(OPENCV3_DIR)/build
	cd $(OPENCV3_DIR)/build/ \
			 && cmake .. -DCMAKE_INSTALL_PREFIX=$(OPENCV3_INSTALL_DIR) \
			 -DCUDA_TOOLKIT_ROOT_DIR=$(CUDA_TOOLKIT_ROOT_DIR) \
			 -DCUDA_GENERATION=Auto

$(OPENCV3_DIR)/CMakeLists.txt: $(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip
	unzip $(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip -d $(dir $(OPENCV3_DIR))
	touch $@

$(OPENCV3_DIR)/.apt-dependencies:
	sudo apt-get install build-essential
	sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
	sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
	touch $@

$(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip:
	curl --header 'Host: codeload.github.com' --header 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --header 'DNT: 1' --header 'Referer: http://opencv.org/downloads.html' --header 'Connection: keep-alive' 'https://codeload.github.com/opencv/opencv/zip/$(OPENCV_VERSION)' -o '$(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip' -L
	touch $@

OPENCV2_DIR=$(INSTALL_PREFIX)/opencv/install/
CAFFE_DIR=$(HOME)/co/caffe
CAFFE_INSTALL_DIR:=$(CAFFE_DIR)/install
LIBRARY_PATH:=$(OPENCV3_INSTALL_DIR)/lib:$(LIBRARY_PATH)

caffe: $(CAFFE_INSTALL_DIR)/lib/libcaffe.so
$(CAFFE_INSTALL_DIR)/lib/libcaffe.so: $(CAFFE_DIR)/build/Makefile
	$(MAKE) -C $(dir $<) install
	touch $@

$(CAFFE_DIR)/build/Makefile: $(CAFFE_DIR)/CMakeLists.txt \
	$(GFLAGS_INSTALL_DIR)/include/gflags/gflags.h \
	$(GLOG_INSTALL_DIR)/include/glog/logging.h \
	$(OPENCV3_INSTALL_DIR)/lib/libopencv_core.so \
	$(CUDA_INSTALLED) \
	$(CUDNN_INSTALLED) \
	$(CAFFE_DIR)/.apt-dependencies
	-mkdir -p $(CAFFE_DIR)/build
	cd $(CAFFE_DIR)/build \
	&& CUDA_BIN_PATH=$(CUDA_TOOLKIT_ROOT_DIR)/bin/ \
		cmake .. -DCMAKE_INSTALL_PREFIX=$(CAFFE_INSTALL_DIR) \
		-DGLOG_ROOT_DIR=$(GLOG_INSTALL_DIR) \
		-DGFLAGS_ROOT_DIR=$(GFLAGS_INSTALL_DIR) \
		-DGLOG_INCLUDE_DIR=$(GLOG_INSTALL_DIR)/include/ \
		-DGFLAGS_INCLUDE_DIR=$(GFLAGS_INSTALL_DIR)/include/ \
		-DGFLAGS_LIBRARY=$(GFLAGS_INSTALL_DIR)/lib/libgflags.so \
		-DOpenCV_DIR=$(OPENCV3_INSTALL_DIR)/share/OpenCV \
		-DCUDNN_ROOT=$(CUDNN_ROOT) \
		-DCUDA_TOOLKIT_ROOT_DIR=$(CUDA_TOOLKIT_ROOT_DIR)/targets/x86_64-linux/

$(CAFFE_DIR)/.apt-dependencies: 
	sudo apt-get install libboost-system-dev libboost-thread-dev libboost-filesystem-dev libboost-python-dev libprotobuf-dev libhdf5-dev liblmdb-dev libleveldb-dev libsnappy-dev libatlas3-base libatlas-base-dev python-numpy doxygen
	touch $@

#DQN_DIR:=dqn-stable
#dqn: $(DQN_DIR)/Makefile caffe opencv2
#	$(MAKE) -C $(DQN_DIR)

#$(DQN_DIR)/Makefile: $(ROOT_DIR)/dqn-stable.tar.gz
#	tar xzvf $<
#	touch $@

$(GFLAGS_DIR)/CMakeLists.txt: 
	cd $(dir $(GFLAGS_DIR)) && \
		git clone https://github.com/gflags/gflags.git $(GFLAGS_DIR)
	cd $(GFLAGS_DIR) && git checkout v2.1.2
	touch $@

$(GFLAGS_DIR)/build/Makefile: $(GFLAGS_DIR)/CMakeLists.txt
	cd  $(GFLAGS_DIR) && mkdir -p build && cd build && cmake .. \
		-DCMAKE_INSTALL_PREFIX=$(GFLAGS_INSTALL_DIR)/ \
		-DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=OFF -DBUILD_PACKAGING=OFF \
		-DBUILD_TESTING=OFF -DBUILD_NC_TESTS=OFF -DBUILD_CONFIG_TESTS=OFF \
		-DINSTALL_HEADERS=ON  \
		-DCUDA_TOOLKIT_ROOT_DIR=$(CUDA_TOOLKIT_ROOT_DIR)

$(GFLAGS_INSTALL_DIR)/include/gflags/gflags.h: $(GFLAGS_DIR)/build/Makefile
	cd $(GFLAGS_DIR)/build && make install
	touch $@

$(GLOG_DIR)/configure:
	cd $(dir $(GLOG_DIR)) && \
		git clone https://github.com/google/glog $(GLOG_DIR)
	cd $(GLOG_DIR) && git checkout v0.3.4
	touch $@

$(GLOG_DIR)/Makefile: $(GLOG_DIR)/configure $(GFLAGS_INSTALL_DIR)/include/gflags/gflags.h
	cd $(GLOG_DIR) && ./configure --prefix=$(GLOG_INSTALL_DIR)/ --enable-shared=yes --enable-static=no --with-gflags=$(GFLAGS_INSTALL_DIR)/lib/..

$(GLOG_INSTALL_DIR)/include/glog/logging.h: $(GLOG_DIR)/Makefile
	cd $(GLOG_DIR) && make install
	touch $@

$(CUDA_INSTALLED):
	sudo apt-add-repository 'deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64 /'
	sudo apt-get update
	sudo apt-get install cuda-7-0

$(CUDNN_INSTALLED):
	sudo rsync -lrczav dhiman@lens:~/co/cudnn/cuda/ $(CUDA_TOOLKIT_ROOT_DIR)/
