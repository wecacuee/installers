CWD:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
PKG:=cartographer
TPD:=$(HOME)/co/
VER:=0.2.1
SD:=$(TPD)/$(PKG)-$(VER)
IP?=$(TPD)/$(PKG)-$(VER)-install

include ceres-solver.mk

$(TPD)/$(PKG)/lib/libcartographer.a:

$(IP)/lib/libcartographer.a: $(SD)/build/Makefile
	cd "$(<D)" && $(MAKE) install

$(TPD)/$(PKG)/%: $(IP)/%
	ln -fsT $(IP) $(TPD)/$(PKG)

$(SD)/build/Makefile: $(SD)/CMakeLists.txt $(Ceres_DIR)/CeresConfig.cmake
	mkdir -p "$(@D)"
	cd "$(@D)" && cmake .. -DCMAKE_INSTALL_PREFIX=$(IP) -DCeres_DIR=$(Ceres_DIR)

$(TPD)/$(PKG)-$(VER)/CMakeLists.txt:
	mkdir -p $(TPD)
	git clone https://github.com/wecacuee/$(PKG).git "$(@D)"
	cd "$(@D)" && git checkout $(VER)
	touch $@

echo-%:
	@echo $($*)
