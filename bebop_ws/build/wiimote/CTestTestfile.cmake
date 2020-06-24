# CMake generated Testfile for 
# Source directory: /home/chris/bebop_ws/src/joystick_drivers/wiimote
# Build directory: /home/chris/bebop_ws/build/wiimote
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_wiimote_roslint_package "/home/chris/bebop_ws/build/wiimote/catkin_generated/env_cached.sh" "/usr/bin/python2" "/opt/ros/melodic/share/catkin/cmake/test/run_tests.py" "/home/chris/bebop_ws/build/wiimote/test_results/wiimote/roslint-wiimote.xml" "--working-dir" "/home/chris/bebop_ws/build/wiimote" "--return-code" "/opt/ros/melodic/share/roslint/cmake/../../../lib/roslint/test_wrapper /home/chris/bebop_ws/build/wiimote/test_results/wiimote/roslint-wiimote.xml make roslint_wiimote")
subdirs("gtest")
