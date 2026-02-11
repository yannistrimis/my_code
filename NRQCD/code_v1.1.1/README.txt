Version 1.1

This version is developed for comparison against PRD 91 054511 (2015)
Particularly, for comparison against Alejandro's MILC implementation.

It differs from 1.0 in the output of 3s1 states. The current version
averages over x,y,z components.

The configuration used for the test is: lat.sample.l8888.trunc

The file s_corrs.sample-out-1 uses just kinetic and sigma.B terms, i.e. cset(1,1) and cset(2,5)
and iaction = 3, mode = 2, bareM = 1.9 and source at (1,1,1,1) (or (0,0,0,0) in MILC notation).

Remarks :

	1. If the code is compiled in double precision the 6*plaquette matches
	MILC plaquette up to 10 significant digits.

	2. The configreadshift() function reads only nt timeslices and discards the rest.

Additions and changes:

userparameters.f90 :

	Precisions KI, KR, KC can be set to double (8) or single (4). Precision 
        of the configuration itself is always single for MILC (KC_CONFIG=4)

gaugefields.f90 :

	Remove endianness flag from open() function.

	The configuration is saved as Uraw_temp and the conversion to 
        double, if needed, is done through 
        Uraw() = cmplx( Uraw_temp(), kind=KC )


mainprogram.f90 :
	
        Call corrfile_<state> to write the meson correlators
        
        In call of configreadshift() argument 0 is passed as 0_KI

        In call of heavyprop() argument 1 is passed as 1_KI

        iaction = 7 corresponds to PRD 91 054511 (2015) setup

heavyoperators.f90 :

	Added ^3S_1 state for x,y,z Pauli matrices.
