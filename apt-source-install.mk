CO?=$(HOME)/co
IP?=$(HOME)/.local
PKG_CONFIG_PATH:=$(IP)/lib/pkgconfig/:$(PKG_CONFIG_PATH)
export PKG_CONFIG_PATH


$(CO)/.install-tree.stamp: $(CO)/.configure-tree.stamp
	cd $(CO)/tree/tree &&\
	make prefix=$(IP) install

$(CO)/.configure-tree.stamp: $(CO)/.source-tree.stamp
	@true

install:=$(CO)/.install-%.stamp
.PRECIOUS: $(install)
.PHONY:
install-%: $(install)
	@true

configure:=$(CO)/.configure-%.stamp
$(install): $(configure)
	cd $(CO)/$*/$* && \
	if [ -f configure ]; then \
		make -j4 install; \
	else \
		cd build && make -j4 install; \
	fi
	touch $@

source:=$(CO)/.source-%.stamp
.PRECIOUS: $(configure) $(source)
$(configure): $(source)
	cd $(CO)/$*/$* && \
	if [ -f configure ]; then \
		./configure --prefix=$(IP); \
	else \
		mkdir -p build && cd build && cmake .. ; \
	fi
	touch $@

$(source):
	mkdir -p $(CO)/$*
	cd $(CO)/$* && \
	apt-get source $* && \
	ln -sfT $$(find . -maxdepth 1 -type d -name '$*[-_]*') $*
	touch $@
