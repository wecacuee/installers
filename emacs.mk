#!/usr/bin/make -f

IP?=/usr/local/
PKG:=emacs
APTPKG:=emacs
VER:=28.2
URL:=https://ftp.gnu.org/gnu/emacs/emacs-$(VER).tar.xz

include common-config.mk

all: $(IP)/bin/$(PKG)
