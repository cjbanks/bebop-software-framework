# CMake generated Testfile for 
# Source directory: /home/chris/bebop-software-framework/bebop_ws/src/joystick_drivers/joy
# Build directory: /home/chris/bebop-software-framework/bebop_ws/build/joy
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_joy_roslint_package "/home/chris/bebop-software-framework/bebop_ws/build/joy/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/melodic/share/catkin/cmake/test/run_tests.py" "/home/chris/bebop-software-framework/bebop_ws/build/joy/test_results/joy/roslint-joy.xml" "--working-dir" "/home/chris/bebop-software-framework/bebop_ws/build/joy" "--return-code" "/opt/ros/melodic/share/roslint/cmake/../../../lib/roslint/test_wrapper /home/chris/bebop-software-framework/bebop_ws/build/joy/test_results/joy/roslint-joy.xml make roslint_joy")
subdirs("gtest")
