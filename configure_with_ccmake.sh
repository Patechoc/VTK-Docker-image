#!/bin/sh


## ENV VARIABLES
PYTHON_INCLUDE_DIR=${PYTHON_INCLUDE_DIR}:/usr/include/python2.7
PYTHON_INCLUDE_DIRS=${PYTHON_INCLUDE_DIRS}:/usr/include/python2.7
PYTHON_LIBRARY=${PYTHON_LIBRARY}:/usr/lib/python2.7/config-x86_64-linux-gnu/libpython2.7.so
PYTHON_LIBRARIES=${PYTHON_LIBRARIES}:/usr/lib/python2.7/config-x86_64-linux-gnu/libpython2.7.so

export PYTHON_INCLUDE_DIR
export PYTHON_INCLUDE_DIRS
export PYTHON_LIBRARY
export PYTHON_LIBRARIES

## CONFIGURE VTK (ccmake)
mkdir -p /opt/VTK-build
cd /opt/VTK-build
pwd
echo "Follow advice from http://www.vtk.org/Wiki/VTK/Configure_and_Build#Configure_VTK_with_CMake"
ccmake /projects/VTK



## CHECK CMAKE CONFIGURATION VARIABLES
echo $BUILD_SHARED_LIBS
echo $BUILD_TESTING
echo $CMAKE_BUILD_TYPE
echo $CMAKE_INSTALL_PREFIX
echo $TODO
echo $QT_QMAKE_EXECUTABLE

## CONFIGURE WITH Qt FOR A NICER UI
echo "Configure Qt for nicer GUI: http://www.vtk.org/Wiki/VTK/Configure_and_Build#Configure_with_Qt"
