ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

################################################################################
# Configuration
################################################################################
INSTALL_PREFIX?=$(HOME)/.local/
SOURCE_PREFIX?=$(HOME)/co

GLOG_DIR?=$(SOURCE_PREFIX)/glog
GLOG_INSTALL_DIR?=$(GLOG_DIR)/install/
GLOG_INSTALLED?=$(GLOG_INSTALL_DIR)/include/glog/logging.h

GFLAGS_DIR?=$(SOURCE_PREFIX)/gflags
GFLAGS_INSTALL_DIR?=$(GFLAGS_DIR)/install/
GFLAGS_INSTALLED?=$(GFLAGS_INSTALL_DIR)/include/gflags/gflags.h

CUDA_TOOLKIT_ROOT_DIR?=/usr/local/cuda-7.0
CUDA_INSTALLED?=$(CUDA_TOOLKIT_ROOT_DIR)/targets/x86_64-linux/lib/libcudart.so
CUDNN_INSTALLED?=$(CUDA_TOOLKIT_ROOT_DIR)/lib64/libcudnn.so
CUDNN_ROOT?=$(CUDA_TOOLKIT_ROOT_DIR)

OPENCV_VERSION?=2.4.13
OPENCV_DIR?=$(SOURCE_PREFIX)/opencv-$(OPENCV_VERSION)
OPENCV_INSTALL_DIR?=$(INSTALL_PREFIX)/opencv-$(OPENCV_VERSION)/install
OPENCV_INSTALLED?=$(OPENCV_INSTALL_DIR)/lib/libopencv_core.so

CAFFE_DIR?=$(SOURCE_PREFIX)/caffe
CAFFE_INSTALL_DIR?=$(CAFFE_DIR)/install
CAFFE_INSTALLED?=$(CAFFE_INSTALL_DIR)/lib/libcaffe.so

################################################################################

.PHONY: all caffe opencv
all: caffe opencv

-include caffe-install.mk
