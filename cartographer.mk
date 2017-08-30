
CWD:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
PKG:=cartographer
TPD:=$(HOME)/co/
VER:=0.2.1
SD:=$(TPD)/$(PKG)-$(VER)
IP?=$(TPD)/$(PKG)-$(VER)-install


RPKG:=cartographer_ros
RTPD:=$(HOME)/co/
RVER:=0.2.1
RSD:=$(RTPD)/$(RPKG)-$(RVER)
RIP?=$(RTPD)/$(RPKG)-$(RVER)-install

all: $(RTPD)/$(RPKG)/bin/cartographer_node

$(IP)/lib/libcartographer.a: $(SD)/build/Makefile
	cd "$(<D)" && $(MAKE) install

$(TPD)/$(PKG)/%: $(IP)/%
	ln -fsT $(IP) $(TPD)/$(PKG)

include $(CWD)/ceres-solver.mk
$(SD)/build/Makefile: $(SD)/CMakeLists.txt $(Ceres_DIR)/CeresConfig.cmake
	mkdir -p "$(@D)"
	cd "$(@D)" \
		&& module load gflags/2.2.1 glog/0.3.5 googletest/1.8.0 \
		&& cmake .. -DCMAKE_INSTALL_PREFIX=$(IP) -DCeres_DIR=$(Ceres_DIR)

$(TPD)/$(PKG)-$(VER)/CMakeLists.txt:
	mkdir -p $(TPD)
	git clone https://github.com/wecacuee/$(PKG).git "$(@D)"
	cd "$(@D)" && git checkout $(VER)
	touch $@

echo-%:
	@echo $($*)


CMAKE_ROS:=$(RTPD)/$(RPKG)-$(RVER)/src/$(RPKG)-$(RVER)/CMakeLists.txt
$(RSD)/devel/cartographer_ros/lib/cartographer_ros/cartographer_node: $(CMAKE_ROS) $(IP)/lib/libcartographer.a
	cd "$(RSD)" \
		&& sudo apt install ros-lunar-eigen-conversions ros-lunar-pcl-conversions ros-lunar-rosbag ros-lunar-tf2 ros-lunar-tf2-eigen ros-lunar-tf2-ros ros-lunar-urdf ros-lunar-visualization-msgs ros-lunar-rviz \
		&& module load googletest \
		&& source /opt/ros/lunar/setup.bash \
		&& cartographer_DIR=$(IP)/share/cartographer/ catkin_make

$(CMAKE_ROS):
	mkdir -p $(RTPD)/$(RPKG)-$(RVER)/src/
	git clone https://github.com/googlecartographer/cartographer_ros.git "$(@D)"
	touch $@
