ROS_VER?=lunar
ROS_ROOT?=/opt/ros/$(ROS_VER)/share/ros
ROS_SHARE?=$(dir $(ROS_ROOT))

packages=rospy tf image_proc stereo_image_proc camera_calibration_parsers auv_msgs nav_msgs
targets=$(foreach pkg,$(packages) \
	,$(ROS_SHARE)/$(pkg)/cmake/$(pkg)Config.cmake)

bag_tools:=src/srv_tools/bag_tools/CMakeLists.txt
all: $(targets) $(bag_tools)
	catkin_make

$(bag_tools):
	git clone https://github.com/srv/srv_tools src/srv_tools
	mv src/srv_tools/bag_tools src/
	rm -rv src/srv_tools/*
	mv src/bag_tools/ src/srv_tools
	touch $@

apt_pkg_names=$(foreach pkg,$(packages),ros-$(ROS_VER)-$(subst _,-,$(pkg)))

$(targets):
	sudo apt-get install $(apt_pkg_names)

print-%:
	@echo $($*)
