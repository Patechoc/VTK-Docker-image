#!/bin/sh

## BUILDING VTK
cd /projects/VTK
mkdir -p build-default

## COMPILING VTK
cd build-default
cmake –G"Unix Makefiles" ../
make #-j2

## INSTALL VTK
make install

## TEST VTK
ctest -R ImageHistogramStatistics
#ctest
