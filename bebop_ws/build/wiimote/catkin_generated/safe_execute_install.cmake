execute_process(COMMAND "/home/chris/bebop_ws/build/wiimote/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/chris/bebop_ws/build/wiimote/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
