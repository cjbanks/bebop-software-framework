# CMake generated Testfile for 
# Source directory: /home/chris/bebop-software-framework/bebop_ws/src/joystick_drivers/spacenav_node
# Build directory: /home/chris/bebop-software-framework/bebop_ws/build/spacenav_node
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_spacenav_node_roslint_package "/home/chris/bebop-software-framework/bebop_ws/build/spacenav_node/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/melodic/share/catkin/cmake/test/run_tests.py" "/home/chris/bebop-software-framework/bebop_ws/build/spacenav_node/test_results/spacenav_node/roslint-spacenav_node.xml" "--working-dir" "/home/chris/bebop-software-framework/bebop_ws/build/spacenav_node" "--return-code" "/opt/ros/melodic/share/roslint/cmake/../../../lib/roslint/test_wrapper /home/chris/bebop-software-framework/bebop_ws/build/spacenav_node/test_results/spacenav_node/roslint-spacenav_node.xml make roslint_spacenav_node")
subdirs("gtest")
