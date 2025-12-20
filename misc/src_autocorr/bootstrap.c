// Bootstrap analysis of time series.
// This program stores full time series in memory.
// It constructs Nboot bootstrap samples with Nsample data
// points per sample. The default version is when Nsample
// is the length of full time series, however, here Nsample
// can be less, and the errorbar is rescaled at the end.
// Based on the Nboot samples, bootstrap error analysis is performed.
// Relies on GSL.
//
// Alexei Bazavov, 2018


// standard includes
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// GSL includes
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>



// MAIN block
int main( int argc, char *argv[] ) {
  // inputs
  int Nboot; // number of bootstrap samples
  int Nsample = 0; // number of data points per bootstrap sample
  int seed; // seed for the random number generator
  char filename[1024];
  FILE *fp;
  // auxiliary
  int Ndat; // total number of analyzed data in the time series
  double *data, *boot; // data and bootstrap samples
  double xtotal, xerror; // accumulators
  // dummy
  double x;
  int i, j, ind;
  // GSL generator
  const gsl_rng_type *T;
  gsl_rng *rGSL;

  
  // print header
  printf( "Bootstrap analysis of time series\n\n" );

  // check command-line arguments
  if( ( 4!=argc ) && ( 5!=argc ) ) {
    printf( "Usage: %s <file> <seed> <Nboot> [<Nsample>]\n", argv[0] );
    printf( "  file -- one-column file with time series\n" );
    printf( "  seed -- for random number generator\n" );
    printf( "  Nboot -- number of bootstrap samples\n" );
    printf( "  Nsample -- number of data points per bootstrap sample (optional)\n" );
    printf( "This program makes two passes and stores full time series in memory.\n" );
    printf( "On the first pass the length of time series Ndat is determined.\n" );
    printf( "On the second pass the data is read in.\n" );
    printf( "The default version of bootstrap is to use Nsample=Ndat.\n" );
    printf( "However, this program supports Nsample<Ndat and then\n" );
    printf( "rescales the errors by sqrt(Nsample/Ndat).\n\n" );
    return 1;
  }

  // process command-line arguments
  strcpy( filename, argv[1] );
  seed = atoi( argv[2] );
  if( seed<0 ) {
    printf( "ERROR: Unreasonable random seed = %d\n", seed );
    printf( "       Adjust seed.\n" );
    return 1;
  }
  Nboot = atoi( argv[3] );
  if( Nboot<1 || Nboot>1.e+20 ) {
    printf( "ERROR: Unreasonable number Nboot = %d\n", Nboot );
    printf( "       Adjust Nboot.\n" );
    return 1;
  }
  if( 5==argc ) {
    Nsample = atoi( argv[4] );
    if( Nsample<1 || Nsample>1.e+20 ) {
      printf( "ERROR: Unreasonable number Nsample = %d\n", Nsample );
      printf( "       Adjust Nsample.\n" );
      return 1;
    }
  }

  
  // check if the input file can be read
  fp = fopen( filename, "rt" );
  if( NULL==fp ) {
    fprintf( stderr, "ERROR: Input file %s cannot be read\n", filename );
    return 1;
  }

  // First pass: determine the number of data in the file
  printf( "First pass -- processing data file: %s\n", filename );
  Ndat = 0;
  while( 1==fscanf( fp, "%lf", &x ) ) Ndat++;
  fclose( fp );
  
  printf( "Total number of data in the file: %d\n", Ndat );
  
  
  // do some checks and adjustments on the sample size
  if( 4==argc ) { // use all data points per sample
    Nsample = Ndat;
  }
  else { // check that Ndat is not smaller than Nsample
    if( Ndat<Nsample ) {
      printf( "WARNING: Number of data points is less than the number of samples:\n" );
      printf( "         Ndat = %d < Nsample = %d\n", Ndat, Nsample );
      Nsample = Ndat;
      printf( "         Adjusting to Nsample = %d\n", Nsample );
    }
  }

  printf( "\nNumber of bootstrap repetitions: %d\n", Nboot );
  printf( "Number of sample data points per repetition: %d\n\n", Nsample );
  
  // prepare storage, set to 0
  data = (double*)calloc( Ndat, sizeof(double) );
  boot = (double*)calloc( Nboot, sizeof(double) );


  // Second pass: read the data
  printf( "Second pass -- read the data\n\n" );
  fp = fopen( filename, "rt" );
  if( NULL==fp ) {
    fprintf( stderr, "ERROR: Input file %s cannot be read\n", filename );
    return 1;
  }
  for( i=0; i<Ndat; i++ ) {
    // get the data
    if( 1!=fscanf( fp, "%lf", &x ) ) {
      printf( "ERROR: Unexpected end of file %s", filename );
      fclose( fp );
      return 1;
    }
    // store full time series
    data[i] = x;
  }
  fclose( fp );


  // initialize the GSL random number generator
  T = gsl_rng_mt19937;
  rGSL = gsl_rng_alloc( T );
  gsl_rng_set( rGSL, seed );

  
  // main bootstrap loop
  for( i=0; i<Nboot; i++ ) {
    // sample the data
    for( j=0; j<Nsample; j++ ) {
      // pick a random index in the full Ndat range
      ind = (int)( Ndat*gsl_rng_uniform( rGSL ) );
      // accumulate the bootstrap sample
      boot[i] += data[ind];
    }
    // normalize the bootstrap sample
    boot[i] /= Nsample;
  }


  // bootstrap error analysis
  xtotal = 0;
  for( i=0; i<Nboot; i++ ) {
    xtotal += boot[i];
  }
  xtotal /= Nboot;
  xerror = 0;
  for( i=0; i<Nboot; i++ ) {
    x = boot[i] - xtotal;
    xerror += x*x;
  }
  xerror /= Nboot;
  if( 5==argc ) { // if Nsample < Ndat we need to rescale
    xerror *= Nsample;
    xerror /= Ndat;
  }
  xerror = sqrt( xerror );
  printf( "Bootstrap error analysis:\n" );
  printf( "x +/- dx = %.16g +/- %.16g\n", xtotal, xerror );


  // output bootstrap samples
  // (useful for getting CDF and asymetric errors)
  fp = fopen( "data_boot.d", "wt" );
  for( i=0; i<Nboot; i++ ) {
    // adjust output formatting here if it does not look nice
    fprintf( fp, "%.16g\n", boot[i] );
  }
  fclose( fp );


  // free GSL generator
  gsl_rng_free( rGSL );

  // free up storage
  free( data );
  free( boot );

  return 0;
}
