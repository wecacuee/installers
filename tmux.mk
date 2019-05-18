#!/usr/bin/make -f

PKG:=tmux
APTPKG:=tmux
VER:=2.9
URL:=https://github.com/tmux/tmux/releases/download/$(VER)/tmux-$(VER).tar.gz

include common.mk

all: $(IP)/bin/$(PKG)
