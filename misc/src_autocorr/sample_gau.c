// Create time series of vectors with
// components x from P(x)~exp(-x^2).
// Algorithms used (compile-time choice):
// 1) Heatbath (directly from GSL)
// 2) Metropolis with Q(z)~1, z=(sqrt(x^2+b^2)-b)/x
// 3) Metropolis with Q(z)~exp(b*(|z|-1)), z=+/-1/(|x|+1)
// 4) Metropolis with step z from P(z)~exp(-z^2/2/b^2)
// The purpose of having different algorithms is to be able
// to create stronger autocorrelated time series,
// either by reducing the acceptance rate or making smaller moves
// (the opposite of what we usually want).
// Relies on GSL.
//
// Alexei Bazavov, Thomas Chuna, 2019


// standard includes
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// GSL includes
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>

// local includes
#include "utils.h"


// const defines
#define PROGRESS_PERCENT 10



// MAIN block
int main( int argc, char *argv[] ) {
  // inputs
  int seed; // random seed
  int Nvec; // size of the vector of Gaussians
  int Ndat; // length of the time series
  double b = 0; // parameter to control acceptance rate
  char filename[1024];

  // auxilliary
  FILE *fp;
  int i, j;
  double *x;
  double rate;
  // progress output
  int iframe, ncross;
  double framelen;

  // GSL generator
  const gsl_rng_type *T;
  gsl_rng *rGSL;


  // algorithm-specific
#ifdef ALG_HEATBATH
  int nargs = 5; // total number of command-line arguments
  int alg = GAUSS_HB;
  char alg_type[] = "Heatbath (currently from GSL)";
  char usage[] = "Usage: %s <seed> <file> <Nvec> <Ndat>\n\n";
#elif ALG_MET_ROOT
  int nargs = 6; // total number of command-line arguments
  int alg = GAUSS_MET_ROOT;
  char alg_type[] = "Metropolis with Q(z)~1, z=(sqrt(x^2+b^2)-b)/x";
  char usage[] = "Usage: %s <seed> <file> <Nvec> <Ndat> <b>\n\n";
#elif ALG_MET_INV
  int nargs = 6; // total number of command-line arguments
  int alg = GAUSS_MET_INV;
  char alg_type[] = "Metropolis with Q(z)~exp(b*(|z|-1)), z=+/-1/(|x|+1)";
  char usage[] = "Usage: %s <seed> <file> <Nvec> <Ndat> <b>\n\n";
#elif ALG_MET_STEP
  int nargs = 6; // total number of command-line arguments
  int alg = GAUSS_MET_STEP;
  char alg_type[] = "Metropolis with step z from P(z)~exp(-z^2/2/b^2)";
  char usage[] = "Usage: %s <seed> <file> <Nvec> <Ndat> <b>\n\n";
#endif


  // print header
  printf( "Generate time series of vectors with components in P(x) ~ exp(-x^2/2)\n" );
  printf( "Algorithm: %s\n\n", alg_type );

  // check command-line arguments
  if( nargs!=argc ) {
    printf( usage, argv[0] );
    return 1;
  }
  seed = atoi( argv[1] ); // random seed
  strcpy( filename, argv[2] ); // filename
  Nvec = atoi( argv[3] ); // size of the vector to generate
  Ndat = atoi( argv[4] ); // length of the time series

  // print parameter info
  printf( "Random seed: %d\n", seed );
  printf( "Vector size: %d\n", Nvec );
  printf( "Time series length: %d\n", Ndat );
  printf( "Output file: %s\n", filename );
#if defined(ALG_MET_INV) || defined(ALG_MET_ROOT) || defined(ALG_MET_STEP)
  b = atof( argv[5] );
  printf( "Parameter b: %lf\n", b );
#endif
  printf( "\n" );


  // initialize the GSL random number generator
  T = gsl_rng_mt19937;
  rGSL = gsl_rng_alloc( T );
  gsl_rng_set( rGSL, seed );

  // initialize Gaussian Metropolis or heatbath
  gauss_met *gm;
  gm = gauss_met_alloc( alg, Nvec, b );
  if( gm==NULL ) return 1;

  // initialize vector
  x = (double*)malloc( Nvec*sizeof(double) );


  // set up progress output
  framelen = Ndat / ( 100./PROGRESS_PERCENT );
  iframe = 1;
  ncross = (int)( framelen*iframe ); // next step at which the frame changes
  printf( "\n" );
  printf( "Progress: %d%%..", 0 );
  fflush( stdout );


  // set up the output
  fp = fopen( filename, "wt" );
  rate = 0;

  // main data generation loop
  for( i=0; i<Ndat; i++ ) {

    // progress output
    if( i>ncross ) { // crossed the next percent label
      printf( "%d%%..", iframe*PROGRESS_PERCENT );
      fflush( stdout );
      iframe++; // move the frame
      ncross = (int)( framelen*iframe ); // set the next step for the frame change
    }

    // generate next Gaussian random vector
    rate += gauss_met_get( rGSL, gm, x );

    // output the components into a file
    fprintf( fp, "%20.16g", x[0] );
    for( j=1; j<Nvec; j++ ) {
      fprintf( fp, " %20.16g", x[j] );
    }
    fprintf( fp, "\n" );

  }
  fclose( fp );

  printf( "100%%\n\n" );
  fflush( stdout );

  printf( "Acceptance rate: " );
  printf( "%g\n", rate/Ndat );

  free( x );
  gauss_met_free( gm );
  return 0;
}
