1.  IN ORDER TO USE MILC ENSEMBLES, tail -c THE BINARY FILE BY THE NUMBER OF BYTES
    THAT THE LATTICE OCCUPIES, WHICH IS vol*4*18*4
    (# OF SITES * # OF DIRS * # OF REAL NUMBERS IN SU(3) MATRIX * SIZE OF FLOAT IN BYTES)

2.  USE SINGLE PRECISION IN RANDY'S CODE
3.  REMOVE ENDIANNESS FLAGS
4.  ADJUST PRECISION AND DIMENSIONS IN userparameters.f90
5.  ADJUST NAME OF LATTICE FILE IN mainprogram.f90
6.  RUN compile FROM THE /build DIRECTORY
