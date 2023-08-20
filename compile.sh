#!/bin/bash
FC="gfortran"
CC=g++
includes=`python -m pybind11 --includes` 
PH5_PATH=/home/l/liuqy/nqdu/software/parallel-hdf5/gcc-8.3.0/
MPICXX=mpic++
EIGEN_INC="/home/l/liuqy/nqdu/software/eigen-3.4.0"
mkdir -p bin

set -x
$FC -g -c -fPIC -shared src/global_parameters.f90 -O3 -o src/global_parameters.o 
$FC -g -c -fPIC -shared src/finite_elem_mapping.f90 -O3 -o src/finite_elem_mapping.o 
$FC -g -c -fPIC -shared src/sem_derivatives.f90 -O3 -o src/sem_derivatives.o 
$FC -g -c -fPIC -shared src/spectral_basis.f90 -O3 -o src/spectral_basis.o 
$CC -g -c src/axisem.cpp -fPIC -shared -o src/axisem.o $includes  -O3
$CC -fPIC -shared src/*.o -O3 -o ./lib/libsem`python3-config --extension-suffix` -lgfortran

\rm src/*.o src/*.mod *mod -f
set +x 