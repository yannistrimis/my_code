// Create time series of x from P(x)~exp(alpha*x)*sqrt(1-x^2).
// Algorithms used (compile-time choice):
// 1) Creutz heatbath,
// 2) Metropolis with Q(x)~1,
// 3) Metropolis with Q(x)~exp(alpha*x),
// 4) Metropolis with Q(x)~(1-x)^n,
// 5) Metropolis with Q(x)~exp(-beta*(1+x)).
// The purpose of having different algorithms is to be able
// to reduce the acceptance rate and create stronger autocorrelated
// time series (the opposite of what we usually want).
// Relies on GSL.
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

// const defines
#define PROGRESS_PERCENT 10


// MAIN block
int main( int argc, char *argv[] ) {
  // inputs
  int Ndat; // length of the time series
  int seed; // random seed
  double alpha; // parameter of the distribution
  char filename[1024];
  // auxilliary
  FILE *fp;
  int i;
  double x, u, rate;
  // progress output
  int iframe, ncross;
  double framelen;

#if defined(ALG_MET_FLAT) || defined(ALG_MET_EXP) \
 || defined(ALG_MET_XN) || defined(ALG_MET_NEGEXP)
  double xnew, pq_x, pq_xnew; // trial move and the probabilities for Metropolis
#endif
  
  // GSL generator
  const gsl_rng_type *T;
  gsl_rng *rGSL;
  
  // algorithm-specific
#ifdef ALG_HEATBATH
  char alg[] = "Creutz heatbath";
  int nargs = 5; // total number of command-line arguments
  char usage[] = "Usage: %s <seed> <file> <N> <alpha>\n\n";
#elif ALG_MET_FLAT
  char alg[] = "Metropolis with Q(x)~1";
  int nargs = 5; // total number of command-line arguments
  char usage[] = "Usage: %s <seed> <file> <N> <alpha>\n\n";
#elif ALG_MET_EXP
  char alg[] = "Metropolis with Q(x)~exp(alpha*x)";
  int nargs = 5; // total number of command-line arguments
  char usage[] = "Usage: %s <seed> <file> <N> <alpha>\n\n";
#elif ALG_MET_XN
  char alg[] = "Metropolis with Q(x)~(1-x)^n";
  int nargs = 6; // total number of command-line arguments
  char usage[] = "Usage: %s <seed> <file> <N> <alpha> <n>\n\n";
  int npower; // power n for the proposal distribution Q(x)
#elif ALG_MET_NEGEXP
  char alg[] = "Metropolis with Q(x)~exp(-beta*(1+x))";
  int nargs = 6; // total number of command-line arguments
  char usage[] = "Usage: %s <seed> <file> <N> <alpha> <beta>\n\n";
  double beta; // parameter for the proposal distribution Q(x)
#endif


  // print header
  printf( "Generate time series of x from P(x)~exp(alpha*x)*sqrt(1-x^2)\n" );
  printf( "Algorithm: %s\n\n", alg );

  // check command-line arguments
  if( nargs!=argc ) {
    printf( usage, argv[0] );
    return 1;
  }
  seed = atoi( argv[1] ); // random seed
  strcpy( filename, argv[2] ); // filename
  Ndat = atoi( argv[3] ); // length of the time series
  alpha = atof( argv[4] ); // alpha (parameter of the target distribution)
#ifdef ALG_MET_XN
  npower = atoi( argv[5] ); // power n for Q(x)~(1-x)^n
#endif
#ifdef ALG_MET_NEGEXP
  beta = atof( argv[5] ); // beta for Q(x)~exp(-beta*(1+x))
#endif

  // print parameter info
  printf( "Random seed: %d\n", seed );
  printf( "Time series length: %d\n", Ndat );
  printf( "alpha: %lf\n", alpha );
  printf( "Output file: %s\n", filename );
#ifdef ALG_MET_XN
  printf( "Power n: %d\n", npower );
#endif
#ifdef ALG_MET_NEGEXP
  printf( "beta: %lf\n", beta );
#endif
  printf( "\n" );
  

  // initialize the GSL random number generator
  T = gsl_rng_mt19937;
  rGSL = gsl_rng_alloc( T );
  gsl_rng_set( rGSL, seed );

  // set up progress output
  framelen = Ndat / ( 100./PROGRESS_PERCENT );
  iframe = 1;
  ncross = (int)( framelen*iframe ); // next step at which the frame changes
  printf( "\n" );
  printf( "Progress: %d%%..", 0 );
  fflush( stdout );
  

  // set up the output and initial state
  fp = fopen( filename, "wt" );
  x = 0.; // starting state
#if defined(ALG_MET_FLAT) || defined(ALG_MET_EXP) \
 || defined(ALG_MET_XN) || defined(ALG_MET_NEGEXP)
  pq_x = 1; // probability of the starting state, ~P(x=0)/Q(x=0)
#endif
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

#ifdef ALG_HEATBATH
    // Creutz heatbath
    do {
      // sample from exp(alpha*x) in [-1,1]
      x = log( ( exp(2*alpha) - 1 ) * gsl_rng_uniform( rGSL ) + 1 ) / alpha - 1;
      u = gsl_rng_uniform( rGSL );
      rate += 1;
    } while ( u>sqrt(1-x*x) ); // filter with sqrt(1-x^2)
#else // Metropolis branch
#if ALG_MET_FLAT
    // sample from uniform [-1,1]
    xnew = 2*gsl_rng_uniform( rGSL ) - 1;
    // evaluate P(xnew)/Q(xnew)
    pq_xnew = exp( alpha*xnew ) * sqrt( 1 - xnew*xnew );
#elif ALG_MET_EXP
    // sample from exp(alpha*x) in [-1,1]
    xnew = log( ( exp(2*alpha) - 1 ) * gsl_rng_uniform( rGSL ) + 1 ) / alpha - 1;
    // evaluate P(xnew)/Q(xnew)
    pq_xnew = sqrt( 1 - xnew*xnew );
#elif ALG_MET_XN
    // sample from (1-x)^n in [-1,1]
    xnew = 1 - 2 * pow( ( 1 - gsl_rng_uniform(rGSL) ) , 1/(npower+1.0) );
    // evaluate P(xnew)/Q(xnew)
    pq_xnew = exp( alpha*xnew ) * sqrt( 1 - xnew*xnew ) / pow( 1.0-xnew, npower );
#elif ALG_MET_NEGEXP
    // sample from exp(-beta*(1+x)) in [-1,1]
    xnew = -1 - log( 1 - gsl_rng_uniform( rGSL ) * ( 1 - exp( -2*beta ) ) ) / beta;
    // evaluate P(xnew)/Q(xnew)
    pq_xnew = exp( alpha*xnew ) * sqrt( 1 - xnew*xnew ) / exp( -beta*(xnew+1) );
#endif // Metropolis choices

    u = gsl_rng_uniform( rGSL );
#ifdef DEBUG_MET_U
    if( 1 ) { // debugging: outputs the proposal distribution
#else
    if( !(u>pq_xnew/pq_x) ) { // accept
#endif
      x = xnew;
      pq_x = pq_xnew;
      rate += 1;
    }
#endif // Heatbath vs Metropolis branch
    fprintf( fp, "%20.16g\n", x );

  } // i
  fclose( fp );

  printf( "100%%\n\n" );
  fflush( stdout );

#ifdef ALG_HEATBATH
  printf( "Rejection overhead: " );
#elif defined(ALG_MET_FLAT) || defined(ALG_MET_EXP) \
   || defined(ALG_MET_XN) || defined(ALG_MET_NEGEXP)
  printf( "Acceptance rate: " );
#endif
  printf( "%g\n", rate/Ndat );

  return 0;
}

