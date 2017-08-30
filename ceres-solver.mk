SHELL:=/bin/bash -l
CWD:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
PKG:=ceres-solver
TPD:=$(HOME)/co/
VER:=1.9.0
SD:=$(TPD)/$(PKG)-$(VER)
IP?=$(TPD)/$(PKG)-$(VER)-install
Ceres_DIR:=$(IP)/lib/cmake/Ceres

$(TPD)/$(PKG)/lib/cmake/Ceres/CeresConfig.cmake:

$(Ceres_DIR)/CeresConfig.cmake: $(SD)/build/Makefile
	cd "$(<D)" && $(MAKE) install

$(TPD)/$(PKG)/%: $(IP)/%
	ln -fsT $(IP) $(TPD)/$(PKG)


$(SD)/build/Makefile: $(SD)/CMakeLists.txt
	mkdir -p "$(@D)"
	cd "$(@D)" \
		&& module load gflags/2.2.1 glog/0.3.5 \
		&& cmake .. -DCMAKE_INSTALL_PREFIX=$(IP)

$(TPD)/$(PKG)-$(VER)/CMakeLists.txt:
	mkdir -p $(TPD)
	git clone https://ceres-solver.googlesource.com/ceres-solver "$(@D)"
	cd "$(@D)" && git checkout $(VER)
	touch $@

echo-%:
	@echo $($*)
