ROOT_DIR?=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
INSTALL_PREFIX?=$(HOME)/co
SOURCE_PREFIX?=$(HOME)/co

OPENCV_VERSION?=2.4.13
OPENCV_DIR?=$(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION)
OPENCV_INSTALL_DIR?=$(INSTALL_PREFIX)/opencv-$(OPENCV_VERSION)/install
OPENCV_INSTALLED?=$(OPENCV_INSTALL_DIR)/lib/libopencv_core.so

opencv: $(OPENCV_INSTALLED)

$(OPENCV_INSTALLED): $(OPENCV_DIR)/build/Makefile
	$(MAKE) -C $(dir $<) install

-include cuda-install.mk
$(OPENCV_DIR)/build/Makefile: $(OPENCV_DIR)/CMakeLists.txt \
	$(OPENCV_DIR)/.sys-dependencies 
	-mkdir -p $(OPENCV_DIR)/build
	cd $(OPENCV_DIR)/build/ \
		&& . $(OPENCV_DIR)/.sys-dependencies \
		&& cmake .. -DCMAKE_INSTALL_PREFIX=$(OPENCV_INSTALL_DIR) \
			 -DCUDA_TOOLKIT_ROOT_DIR=$${CUDA_ROOT} \
			 -DCUDA_USE_STATIC_CUDA_RUNTIME=OFF \
			 -DCUDA_GENERATION=Auto

$(OPENCV_DIR)/CMakeLists.txt: $(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip
	unzip $(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip -d $(dir $(OPENCV_DIR))
	touch $@

$(OPENCV_DIR)/.sys-dependencies: $(if $(isflux), ,$(CUDA_INSTALLED))
ifeq ($(isflux),arc-ts)
	echo "module load gcc/4.8.5 cmake intel-tbb hdf5 cuda/7.5 cudnn/7.0-v4" > $@
else
	sudo apt-get install build-essential
	sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
	sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
	echo "export CUDA_ROOT=$(CUDA_TOOLKIT_ROOT_DIR)" > $@
endif

$(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip:
	curl --header 'Host: codeload.github.com' --header 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --header 'DNT: 1' --header 'Referer: http://opencv.org/downloads.html' --header 'Connection: keep-alive' 'https://codeload.github.com/opencv/opencv/zip/$(OPENCV_VERSION)' -o '$(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip' -L
	touch $@

