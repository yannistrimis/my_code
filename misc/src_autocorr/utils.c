// Auxilliary functions
//
// Alexei Bazavov, Thomas Chuna, 2019

#include <stdio.h>
#include <math.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include "utils.h"


/*
 A set of functions to generate a vector of Gaussian distributed random
 numbers from P(x) ~ exp( -x^2/2 ). The Metropolis-type algorithms allow
 for a tunable parameter to induce autocorrelations.
 
 Algorithm sketch:
 
 GAUSS_HB:
 Generate Gaussian distributed random numbers with heatbath,
 uncorrelated
 
 GAUSS_MET_INV:
 Remap x in [-inf,inf] to
 z = 1/(x-1), x<0, z = 1/(x+1), x>=0
 z in [-1,1].
 The target distribution is P(z) ~ exp( -(1/|z|-1)^2/2 ) / z^2,
 the proposal distribution Q(z) ~ exp ( b(|z|-1) ), where
 b is a tunable parameter, larger b leads to lower acceptance rate.
 Use Metropolis to generate z with P(z)/Q(z), then convert back to x:
 x = 1/z+1, z<0, x = 1/z-1, z>0.
 
 GAUSS_MET_ROOT:
 Remap x in [-inf,inf] to
 z = (sqrt(x^2+b^2)-b)/x, if need to convert for small x,
 z ~ x/2b * (1 - (x/2b)^2).
 The target distribution is
 P(z) ~ (1+z^2)/(1-z^2)^2*exp( -2(bz/(1-z^2))^2 ), where
 b is a tunable parameter, larger b leads to lower acceptance rate.
 Use Metropolis to generate z with P(z), then convert back to
 x=2bz/(1-z^2).
 
 GAUSS_MET_STEP:
 Let x be the current value in the time series. Generate a Gaussian
 distributed z with the width b. Then propose a new move
 to x' = x + z. Use Metropolis with P(x') ~ exp( -x'^2/2 ).
 Lower values of b lead to small moves and thus to high acceptance
 rate but high autocorrelation.
 
 */


// allocate the structure and set the parameters
gauss_met* gauss_met_alloc( int alg_type, int N, double b ) {
  
  int i;
  
  // check if the algorithm is legitimate
  if( alg_type!=GAUSS_MET_INV
     && alg_type!=GAUSS_MET_ROOT
     && alg_type!=GAUSS_MET_STEP
     && alg_type!=GAUSS_HB ) {
    return NULL;
  }
  
  // allocate space
  gauss_met *gm = malloc( sizeof(gauss_met) );
  if( gm==NULL) return NULL;
  
  // set the algorithm type
  gm->alg_type = alg_type;
  
  // set the size of the vector
  gm->N = N;
  
  // if using heatbath the rest is not needed
  if( alg_type==GAUSS_HB ) return gm;
  
  // set the parameter, its meaning depends on the algorithm type
  gm->b = b;
  
  // allocate arrays for the current state and the probabilities
  gm->state = calloc( N, sizeof(double) );
  if( gm->state==NULL ) {
    free( gm );
    return NULL;
  }
  gm->probability = calloc( N, sizeof(double) );
  if( gm->probability==NULL ) {
    free( gm->state );
    free( gm );
    return NULL;
  }
  
  // for the inverse mapping the initial state is z=1
  if( alg_type==GAUSS_MET_INV ) {
    for( i=0; i<N; i++ ) {
      gm->state[i] = 1;
    }
  }
  
  return gm;
}


// free the arrays and the structure
void gauss_met_free( gauss_met *gm ) {
  
  if( gm->alg_type!=GAUSS_HB ) {
    // free arrays
    free( gm->state );
    free( gm->probability );
  }
  
  // free the structure
  free( gm );
}


// generate a vector of Gaussian distributed numbers ~ exp( -x^2/2 )
double gauss_met_get( gsl_rng *rnd, gauss_met *gm, double *x ) {
  
  int i;
  double acpt = 0;
  double u, v, z = 0, pq_new = 1;
  double expb = 1, expb1 = 1;
  
  // precalculate constants
  if( gm->alg_type==GAUSS_MET_INV ) {
    expb = exp( -gm->b );
    expb1 = 1 - expb;
  }
  else if( gm->alg_type==GAUSS_MET_ROOT ) {
    expb = -2 * gm->b * gm->b;
  }
  
  
  // loop over the vector components
  for( i=0; i<gm->N; i++ ) {
    
    switch( gm->alg_type ) {
        
      case GAUSS_HB:
        
        // simply take a GSL Gaussian, nothing else
        x[i] = gsl_ran_gaussian( rnd, 1 );
        acpt += 1;
        break;
        
      case GAUSS_MET_INV:
        
        // sample uniform in [-1,1]
        z = 2*gsl_rng_uniform( rnd ) - 1;
        // convert to z with the proposal Q(z)
        if( z<0 ) {
          z = - 1 - log( 1 - expb1 * ( 1 + z ) ) / gm->b;
        }
        else {
          z =   1 + log( expb      + expb1*z   ) / gm->b;
        }
        
        // evaluate the ratio of probabilities
        u = fabs( z );
        v = 1/u - 1;
        u = u - 1;
        pq_new = v*v/2 + gm->b*u;
        u = z * z;
        pq_new = exp( -pq_new ) / u;
        break;
        
      case GAUSS_MET_ROOT:
        
        // sample from uniform [-1,1]
        z = 2*gsl_rng_uniform( rnd ) - 1;
        
        // evaluate the ratio of probabilities
        u = z*z;
        v = 1 - u;
        v *= v;
        pq_new = ( 1 + u ) * exp( expb * u / v ) / v;
        break;
        
      case GAUSS_MET_STEP:
        
        // sample from a Gaussian with b
        z = gsl_ran_gaussian( rnd, gm->b );
        // make a move
        z = gm->state[i] + z;
        pq_new = exp( -z*z/2 );
        break;
        
    } // switch( gm->alg_type )
    
    if( gm->alg_type!=GAUSS_HB ) {
      
      // common accept/reject
      u = gsl_rng_uniform( rnd );
      if( !(u>pq_new/gm->probability[i]) ) { // accept
        gm->state[i] = z;
        gm->probability[i] = pq_new;
        acpt += 1;
      }
      
      // convert from z to x if needed
      switch( gm->alg_type ) {
          
        case GAUSS_MET_INV:
          
          x[i] = 1 / gm->state[i];
          x[i] = ( x[i]<0 ) ? x[i] + 1 : x[i] - 1;
          break;
          
        case GAUSS_MET_ROOT:
          
          x[i] = 2 * gm->b * gm->state[i] / ( 1 - gm->state[i] * gm->state[i] );
          break;
          
        case GAUSS_MET_STEP:
          
          x[i] = gm->state[i];
          break;
          
      }
      
    } // if( alg_type!=GAUSS_HB )
    
  } // loop on the vector components
  
  // rescale the acceptance by the number of vector components
  return acpt / gm->N;
}
