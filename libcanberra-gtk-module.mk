
CO:=$(HOME)/co

all: install-libcanberra
install-libcanberra: install-libvorbis
install-libvorbis: install-libogg

include apt-source-install.mk

