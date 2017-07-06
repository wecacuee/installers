ROS_VER?=lunar
ROS_ROOT?=/opt/ros/$(ROS_VER)/share/ros
ROS_SHARE?=$(dir $(ROS_ROOT))

packages=cmake-modules roslang rosboost-cfg
targets=$(foreach pkg,$(packages) \
	,$(ROS_SHARE)/$(pkg)/cmake/$(pkg)Config.cmake)

lsd_slam_core:=lsd_slam/lsd_slam_core/CMakeLists.txt
all: $(lsd_slam_core) $(targets) 
	mkdir -p $(<D)/build
	cd $(<D)/build && \
	cmake ..

$(lsd_slam_core):
	git clone https://github.com/tum-vision/lsd_slam.git lsd_slam
	touch $@

apt_pkg_names=$(foreach pkg,$(packages),ros-$(ROS_VER)-$(subst _,-,$(pkg)))

$(targets):
	sudo apt-get install $(apt_pkg_names)

print-%:
	@echo $($*)
