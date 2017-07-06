TMPDIR:=$(HOME)/co/
SHELL:=/bin/bash

all: $(TMPDIR)/video_segment/build_sts/Makefile

include $(dir $(lastword $(MAKEFILE_LIST)))/ffmpeg-install.mk

.ONESHELL:
$(TMPDIR)/video_segment/build_sts/seg_tree_sample: $(FFMPEG_INSDIR)/bin/ffmpeg $(TMPDIR)/video_segment/seg_tree_sample/CMakeLists.txt
	cd $(TMPDIR)/video_segment
	mkdir -p build_sts
	cd build_sts
	module load gflags glog cuda opencv/2.4.13 ffmpeg/2.2.3
	cmake ../seg_tree_sample/
	export CPLUS_INCLUDE_PATH=$$GFLAGS_INC:$$GLOG_INC
	echo $$CPLUS_INCLUDE_PATH
	$(MAKE)

$(TMPDIR)/video_segment/seg_tree_sample/CMakeLists.txt:
	cd $(TMPDIR)
	git clone https://github.com/videosegmentation/video_segment.git


