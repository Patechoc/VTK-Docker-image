#!/bin/sh

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
