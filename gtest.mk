CWD:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
TPD:=$(HOME)/co/
VER:=1.8.0
SD:=$(TPD)/googletest-$(VER)
IP?=$(TPD)/googletest-$(VER)-install

$(TPD)/gtest/lib/libgtest.so: $(IP)/lib/libgtest.so
	ln -fsT googletest-$(VER)-install $(TPD)/gtest

$(IP)/lib/libgtest.so: $(SD)/build/Makefile
	cd "$(<D)" && $(MAKE) install

$(SD)/build/Makefile: $(SD)/CMakeLists.txt
	mkdir -p "$(@D)"
	cd "$(@D)" && cmake .. -DCMAKE_INSTALL_PREFIX=$(IP) -DBUILD_SHARED_LIBS=On

$(TPD)/googletest-$(VER)/CMakeLists.txt:
	mkdir -p $(TPD)
	git clone https://github.com/google/googletest.git "$(@D)"
	cd "$(@D)" && git checkout release-$(VER)
	touch $@

echo-%:
	@echo $($*)
