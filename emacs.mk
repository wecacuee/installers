#!/usr/bin/make -f

PKG:=emacs
APTPKG:=emacs24
VER:=26.2
URL:=https://ftp.gnu.org/gnu/emacs/emacs-$(VER).tar.xz

include common-config.mk

all: $(IP)/bin/$(PKG)
