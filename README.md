# VTK in Docker
The Visualization Toolkit ([VTK](http://www.vtk.org/Wiki/VTK)) by Kitware is a software system for 3D computer graphics, image processing, and visualization.
This repository aims at running VTK within a Docker image, benefiting from [all Docker's advantages](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/7.0_Release_Notes/sect-Red_Hat_Enterprise_Linux-7.0_Release_Notes-Linux_Containers_with_Docker_Format-Advantages_of_Using_Docker.html):

> **Rapid application deployment** – containers include the minimal runtime requirements of the application, reducing their size and allowing them to be deployed quickly.

> **Portability across machines** – an application and all its dependencies can be bundled into a single container that is independent from the host version of Linux kernel, platform distribution, or deployment model. This container can be transfered to another machine that runs Docker, and executed there without compatibility issues.

> **Version control and component reuse** – you can track successive versions of a container, inspect differences, or roll-back to previous versions. Containers reuse components from the preceding layers, which makes them noticeably lightweight.

> **Sharing** – you can use a remote repository to share your container with others. Red Hat provides a registry for this purpose, and it is also possible to configure your own private repository.

> **Lightweight footprint and minimal overhead** – Docker images are typically very small, which facilitates rapid delivery and reduces the time to deploy new application containers.

> **Simplified maintenance** – Docker reduces effort and risk of problems with application dependencies.  


This repository contains a Dockerfile that builds VTK (version 6) on top of Ubuntu 14.04 following Kitware's instructions ([VTK:Configure and Build Instructions](http://www.vtk.org/Wiki/VTK/Configure_and_Buildx)) and inspired from  Matt McCormick's Docker image: https://github.com/KitwareMedical/docker-pluslib/blob/master/Dockerfile.

## A work in progress...

Still working on the GUI problem within Docker. Not a fully running VTK yet, but soon! ;)
The latest automated build from this repository build and compiles VTK with some tests failing (maybe due to the abscence of X server detected), and is available on [DockerHub](https://registry.hub.docker.com/u/patrickmerlot/vtk6/).


## Commands
### Building the Docker image from the Dockerfile
sudo docker build --rm -t patrickmerlot/vtk6 .
### Running VTK within Docker
sudo docker run -ti patrickmerlot/vtk6

### Launch the test suite (Ctest)
Check the status of this build by yourself like so:

```shell
$ sudo docker run -ti patrickmerlot/vtk6
root@15d49326bea0:/projects/VTK/BUILD-DEFAULT# ctest
```

## VTK Example for testing
http://www.bu.edu/tech/support/research/training-consulting/online-tutorials/vtk/
http://www.vtk.org/Wiki/VTK/Examples/Python/Cylinder

## TODO
### VTK CDash Dashboard (nightly testing on various plateform)
### VTK continuous delivery (using Wercker)