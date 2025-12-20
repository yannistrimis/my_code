// Perform Gaussian difference test
//
// Alexei Bazavov, Thomas Chuna, 2018


// standard includes
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// GSL includes
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include <gsl/gsl_sf_erf.h>


// MAIN block
int main( int argc, char *argv[] ) {
  // inputs
  double XM1, XM2, XERR1, XERR2;
  // auxiliary
  double sigma, XX;
  // dummy
  double Q;

  // print header
  printf( "Gaussian Difference Test (Z-test)\n\n" );

  // check command-line arguments
  if( 5!=argc ) {
    printf( "Usage: %s <mean1> <error1> <mean2> <error2> \n", argv[0] );
    printf( "  mean -- average value\n" );
    printf( "  error -- standard deviation of the mean \n" );
    printf( "This program takes two sets of mean and error.\n" );
    printf( "Then assuming the mean is gaussian distributed it\n" );
    printf( "computes the likelihood that the discrepancy is due to chance.\n" );
    return 1;
  }

  // process command-line arguments
  XM1   = atof( argv[1] );
  XERR1 = atof( argv[2] );
  XM2   = atof( argv[3] );
  XERR2 = atof( argv[4] );

  // mirror the input to output
  printf( "Comparing:\n" );
  printf( "x1 +/- dx1 = %.16g +/- %.16g\n", XM1, XERR1 );
  printf( "x2 +/- dx2 = %.16g +/- %.16g\n", XM2, XERR2 );
  printf( "\n" );


  // run Gaussian difference test
  sigma = sqrt( XERR1*XERR1 + XERR2*XERR2 );
  XX = fabs( XM1-XM2 ) / ( sigma*sqrt(2) );
  Q = 1 - gsl_sf_erf(XX);

  // output the result
  printf( "Likelihood that discrepancy is due to chance: %.16g\n",Q);

  return 0;
}
