#!/usr/bin/make -f
SHELL=/bin/bash -l
ROOT_DIR?=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))


INSTALL_PREFIX?=$(HOME)/.local/
SOURCE_PREFIX?=$(HOME)/.local/src/

OPENCV_VERSION?=4.2.0
OPENCV_DIR?=$(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION)
OPENCV_INSTALL_DIR?=$(INSTALL_PREFIX)/opencv/$(OPENCV_VERSION)/
OPENCV_INSTALLED?=$(OPENCV_INSTALL_DIR)/lib/libopencv_core.so

OPENCVCONTRIB_DIR?=$(SOURCE_PREFIX)/opencv_contrib-$(OPENCV_VERSION)

opencv: $(OPENCV_INSTALLED)

$(OPENCV_INSTALLED): $(OPENCV_DIR)/build/Makefile
	$(MAKE) -C $(dir $<) install

CUDA_ROOT?=/usr/local/cuda/
#-include cuda-install.mk
$(OPENCV_DIR)/build/Makefile: $(OPENCV_DIR)/CMakeLists.txt $(OPENCV_DIR)/.sys-dependencies $(OPENCVCONTRIB_DIR)/modules/README.md
	-mkdir -p $(OPENCV_DIR)/build
	cd $(OPENCV_DIR)/build/ \
		&& . $(OPENCV_DIR)/.sys-dependencies \
		&& cmake .. -DCMAKE_INSTALL_PREFIX=$(OPENCV_INSTALL_DIR) \
			 -DCUDA_TOOLKIT_ROOT_DIR=$${CUDA_ROOT} \
				-DOPENCV_EXTRA_MODULES_PATH=$(OPENCVCONTRIB_DIR)/modules \
				-DOPENCV_ENABLE_NONFREE=True \
				-DWITH_VTK=OFF \
				-DBUILD_JAVA=OFF 


$(OPENCV_DIR)/CMakeLists.txt: $(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip
	unzip $(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip -d $(dir $(OPENCV_DIR))
	touch $@

$(OPENCVCONTRIB_DIR)/modules/README.md: $(SOURCE_PREFIX)/opencv_contrib-$(OPENCV_VERSION).zip
	unzip $< -d $(dir $(OPENCVCONTRIB_DIR))
	touch $@

$(OPENCV_DIR)/.sys-dependencies: #$(if $(isflux), ,$(CUDA_INSTALLED))
	# apt-get install build-essential
	# apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
	# apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
	# echo "module load cuda miniconda3 numpy/py3.6 matlab" > $@
	echo "echo sourcing sys-dependencies" >> $@

$(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION).zip:
	curl --header 'Host: codeload.github.com' --header 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --header 'DNT: 1' --header 'Referer: http://opencv.org/downloads.html' --header 'Connection: keep-alive' 'https://codeload.github.com/opencv/opencv/zip/$(OPENCV_VERSION)' -o '$@' -L
	touch $@


$(SOURCE_PREFIX)/opencv_contrib-$(OPENCV_VERSION).zip:
	curl --header 'Host: codeload.github.com' --header 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0' --header 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' --header 'Accept-Language: en-US,en;q=0.5' --header 'DNT: 1' --header 'Referer: http://opencv.org/downloads.html' --header 'Connection: keep-alive' 'https://codeload.github.com/opencv/opencv_contrib/zip/$(OPENCV_VERSION)' -o '$@' -L
	touch $@
