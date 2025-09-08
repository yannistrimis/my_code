This version (1.0) is developed for comparison against PRD 91 054511 (2015)

Additions and changes:

1st batch:

userparameters.f90 :
	All precisions are single: KI=KR=KC=4

gaugefields.f90 :
	Remove endianness flag from open() function

mainprogram.f90 :
	Set cutboundaries = .false. before calling aveplaq() function

