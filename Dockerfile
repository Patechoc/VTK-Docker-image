FROM ubuntu:14.04
MAINTAINER Patrick Merlot <patrick.merlot@gmail.com>

## inspired from  Matt McCormick's Docker image: https://github.com/KitwareMedical/docker-pluslib/blob/master/Dockerfile
## Following also instruction stated in http://www.vtk.org/Wiki/VTK/Configure_and_Build and https://www.comp.nus.edu.sg/~leowwk/install-vtk.html

## SETTING PATHS annd ENVIRONMENT VARIABLES
ENV PATH ${PATH}:/usr/bin:/bin:/usr/sbin:/sbin
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHON_INCLUDE_DIR   ${PYTHON_INCLUDE_DIR}:/usr/include/python2.7
ENV PYTHON_INCLUDE_DIRS ${PYTHON_INCLUDE_DIRS}:/usr/include/python2.7
ENV PYTHON_LIBRARY      ${PYTHON_LIBRARY}:/usr/lib/python2.7/config-x86_64-linux-gnu/libpython2.7.so
ENV PYTHON_LIBRARIES  ${PYTHON_LIBRARIES}:/usr/lib/python2.7/config-x86_64-linux-gnu/libpython2.7.so

## INSTALL DEPENDENCIES
RUN apt-get update

RUN apt-get install -y \
     build-essential \
     cmake \
     cmake-curses-gui \
     git \
     libinsighttoolkit4-dev \
     libqt4-dev \
     libxt-dev \
     make \
     python-vtk \
     ninja-build \
     subversion \
     tcl-vtk


## VERSION's DEPENDENCIES
RUN cmake --version
RUN ctest --version
RUN make --version
RUN echo $PATH


## DOWNLOAD VTK SOURCE
RUN mkdir -p /projects
WORKDIR /projects
RUN git clone --progress --verbose http://vtk.org/VTK.git
RUN pwd
RUN ls
WORKDIR VTK
RUN pwd
RUN ls

## UPDATE THE CODE
RUN git fetch origin
RUN git rebase origin/master


## CONFIGURE (similar to the use of ccmake) VTK DEBUG BUILD
ADD setup.py /projects/VTK/
RUN chmod +x setup.py
RUN mkdir -p /opt/build_VTK6.2_DEBUG
WORKDIR /opt/build_VTK6.2_DEBUG
RUN pwd
RUN echo "Following advice from http://www.vtk.org/Wiki/VTK/Configure_and_Build#Configure_VTK_with_CMake"
RUN python /projects/VTK/setup.py --type=debug --timings -DBUILD_SHARED_LIBS:BOOL=ON -DBUILD_EXAMPLES:BOOL=ON -DBUILD_TESTING:BOOL=ON /opt/build_VTK6.2_DEBUG

## COMPILE VTK
WORKDIR /opt/build_VTK6.2_DEBUG
RUN make -j4
RUN make install


## CHECK CMAKE CONFIGURATION VARIABLES
echo $BUILD_SHARED_LIBS
echo $BUILD_TESTING
echo $CMAKE_BUILD_TYPE
echo $CMAKE_INSTALL_PREFIX
echo $TODO
echo $QT_QMAKE_EXECUTABLE

## CONFIGURE WITH Qt FOR A NICER UI
echo "Configure Qt for nicer GUI: http://www.vtk.org/Wiki/VTK/Configure_and_Build#Configure_with_Qt"


## TEST THE NEW BUILD
RUN ctest -R ImageHistogramStatistics
#RUN ctest