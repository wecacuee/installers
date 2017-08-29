TD:=$(dir $(lastword $(MAKEFILE_LIST)))
include $(TD)/common.mk
SD?=$(HOME)/co/video_segment
SHELL:=/bin/bash -l

all: $(SD)/build_segment_converter $(SD)/build_seg_tree_sample

$(SD)/build_%: $(SD)/%/CMakeLists.txt $(SD)/.git
	mkdir -p "$@" &&  \
	module load ffmpeg cuda opencv/2.4.13 gflags glog/0.3.5 && \
	cd "$@" && cmake $(SD)/$* && \
	CPATH=$$GFLAGS_INC:$$GLOG_INC:$$FFMPEG_INC:$$CPATH $(MAKE) -C "$@" && \
	touch "$@" || rm -rf "$@"

$(SD)/.git:
	git clone https://github.com/videosegmentation/video_segment $(@D)
	touch $@
