#ifndef UTILS_H_
#define UTILS_H_

// Auxilliary functions
//
// Alexei Bazavov, Thomas Chuna, 2019

#include <stdio.h>

// GSL includes
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>



// types of algorithms for generating vectors of
// Gaussian random numbers ~ exp( -x^2/2 )
#define GAUSS_HB       0
#define GAUSS_MET_INV  1
#define GAUSS_MET_ROOT 2
#define GAUSS_MET_STEP 3


// type for generating vectors of Gaussians
typedef struct {
  int alg_type;
  int N;    // vector size
  double b; // tunable parameter, its meaning depends on the algorithm
  double *state; // previous state for Metropolis algorithm,
    // for some algorithms we store not x but a remapped variable z
  double *probability; // previous value of the probability for accept/reject
} gauss_met;


// allocate the structure and set the parameters
gauss_met* gauss_met_alloc( int alg_type, int N, double b );

// free the arrays and the structure
void gauss_met_free( gauss_met *gm );

// generate a vector of Gaussian distributed numbers ~ exp( -x^2/2 )
double gauss_met_get( gsl_rng *rnd, gauss_met *gm, double *x );

#endif

