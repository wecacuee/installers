SHELL:=/bin/bash -l
CWD:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
Ceres_PKG:=ceres-solver
Ceres_TPD:=$(HOME)/co/
Ceres_VER:=1.9.0
Ceres_SD:=$(Ceres_TPD)/$(Ceres_PKG)-$(Ceres_VER)
Ceres_IP?=$(Ceres_TPD)/$(Ceres_PKG)-$(Ceres_VER)-install
Ceres_DIR:=$(Ceres_IP)/lib/cmake/Ceres

$(Ceres_TPD)/$(Ceres_PKG)/lib/cmake/Ceres/CeresConfig.cmake:

$(Ceres_DIR)/CeresConfig.cmake: $(Ceres_SD)/build/Makefile
	cd "$(<D)" && $(MAKE) install

$(Ceres_TPD)/$(Ceres_PKG)/%: $(Ceres_IP)/%
	ln -fsT $(Ceres_IP) $(Ceres_TPD)/$(Ceres_PKG)


$(Ceres_SD)/build/Makefile: $(Ceres_SD)/CMakeLists.txt
	mkdir -p "$(@D)"
	cd "$(@D)" \
		&& module load gflags/2.2.1 glog/0.3.5 \
		&& cmake .. -DCMAKE_INSTALL_PREFIX=$(Ceres_IP)

$(Ceres_TPD)/$(Ceres_PKG)-$(Ceres_VER)/CMakeLists.txt:
	mkdir -p $(Ceres_TPD)
	git clone https://ceres-solver.googlesource.com/ceres-solver "$(@D)"
	cd "$(@D)" && git checkout $(Ceres_VER)
	touch $@

echo-%:
	@echo $($*)
