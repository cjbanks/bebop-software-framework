# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.11

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/chris/bebop-software-framework/bebop_ws/src/joystick_drivers/wiimote

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/chris/bebop-software-framework/bebop_ws/build/wiimote

# Utility rule file for clean_test_results_wiimote.

# Include the progress variables for this target.
include CMakeFiles/clean_test_results_wiimote.dir/progress.make

CMakeFiles/clean_test_results_wiimote:
	/usr/bin/python2 /opt/ros/melodic/share/catkin/cmake/test/remove_test_results.py /home/chris/bebop-software-framework/bebop_ws/build/wiimote/test_results/wiimote

clean_test_results_wiimote: CMakeFiles/clean_test_results_wiimote
clean_test_results_wiimote: CMakeFiles/clean_test_results_wiimote.dir/build.make

.PHONY : clean_test_results_wiimote

# Rule to build all files generated by this target.
CMakeFiles/clean_test_results_wiimote.dir/build: clean_test_results_wiimote

.PHONY : CMakeFiles/clean_test_results_wiimote.dir/build

CMakeFiles/clean_test_results_wiimote.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/clean_test_results_wiimote.dir/cmake_clean.cmake
.PHONY : CMakeFiles/clean_test_results_wiimote.dir/clean

CMakeFiles/clean_test_results_wiimote.dir/depend:
	cd /home/chris/bebop-software-framework/bebop_ws/build/wiimote && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/chris/bebop-software-framework/bebop_ws/src/joystick_drivers/wiimote /home/chris/bebop-software-framework/bebop_ws/src/joystick_drivers/wiimote /home/chris/bebop-software-framework/bebop_ws/build/wiimote /home/chris/bebop-software-framework/bebop_ws/build/wiimote /home/chris/bebop-software-framework/bebop_ws/build/wiimote/CMakeFiles/clean_test_results_wiimote.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/clean_test_results_wiimote.dir/depend

