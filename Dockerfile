FROM ubuntu:14.04
MAINTAINER Patrick Merlot <patrick.merlot@gmail.com>

## inspired from  Matt McCormick's Docker image: https://github.com/KitwareMedical/docker-pluslib/blob/master/Dockerfile
## Following also instruction stated in http://www.vtk.org/Wiki/VTK/Configure_and_Build and https://www.comp.nus.edu.sg/~leowwk/install-vtk.html

## SETTING PATHS annd ENVIRONMENT VARIABLES
ENV PATH ${PATH}:/usr/bin:/bin:/usr/sbin:/sbin
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHON_INCLUDE_DIR ${PYTHON_INCLUDE_DIR}:/usr/include/python2.7
ENV PYTHON_LIBRARY ${PYTHON_LIBRARY}:/usr/lib/python2.7/config-x86_64-linux-gnu/libpython2.7.so

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

## ------ MANUAL COMMANDS TO PERFORM WHILE RUNNING THE IMAGE IN DOCKER  --------
ADD configure_with_ccmake.sh /projects/VTK/
ADD build_compile_install_test.sh /projects/VTK/
RUN chmod +x configure_with_ccmake.sh build_compile_install_test.sh
CMD [ "sh", "-c", "/projects/VTK/configure_with_ccmake.sh"]
