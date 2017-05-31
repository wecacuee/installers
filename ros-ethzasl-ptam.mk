.PHONY:compile run
PTAMCC:=devel/lib/ptam/cameracalibrator
compile: $(PTAMCC)

# Install ROS
/etc/apt/sources.list.d/ros-latest.list:
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
	sudo apt-get update

# 
/opt/ros/indigo/setup.bash:
	sudo apt-get install ros-indigo-desktop-full

# Checkout uvc_cam
src/usb_cam/CMakeLists.txt:
	cd src && git clone https://github.com/bosch-ros-pkg/usb_cam.git

# Install uvc_cam
devel/lib/usb_cam/usb_cam_node: src/usb_cam/CMakeLists.txt /opt/ros/indigo/setup.bash
	source /opt/ros/indigo/setup.bash && catkin_make

# Checkout ethzasl_ptam
src/ethzasl_ptam/README.md:
	cd src && git clone https://github.com/ethz-asl/ethzasl_ptam.git

# Compile ethzasl_ptam
$(PTAMCC): src/ethzasl_ptam/README.md devel/lib/usb_cam/usb_cam_node /opt/ros/indigo/setup.bash
	source /opt/ros/indigo/setup.bash && catkin_make


# Run 
run: $(PTAMCC) /opt/ros/indigo/setup.bash
	source devel/setup.bash && roslaunch cog_ptam_test camera_calibrate.launch
