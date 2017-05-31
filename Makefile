ROOTDIR:=$(abspath $(lastword $(MAKEFILE_LIST)))

co/glog/configure:

/usr/lib/python2.7/dist-packages/cv2.so: 
	sudo apt-get install python-opencv

co/deep-visualization-toolbox/:

DDIR:=$(HOME)/co
$(DDIR)/opengm/CMakeLists.txt:
	git clone https://github.com/opengm/opengm 
