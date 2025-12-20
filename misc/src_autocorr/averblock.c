// Binning analysis of time series.
// This program does not read in the time series in memory,
// but requires two passes to determine the number of data entries.
// It calculates naive and binned mean and the error bar of the mean.
// The binned data are stored at the end, so future
// processing is also possible.
//
// Alexei Bazavov, 2019


// standard includes
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>



// MAIN block
int main( int argc, char *argv[] ) {
  // inputs
  int Nbins; // number of bins
  char filename[1024];
  FILE *fp;
  // auxiliary
  int Ndat; // total number of analyzed data in the time series
  int Nperbin; // number of data per bin
  double *data_bin; // bins
  double xtotal, x2total, xerror; // accumulators
  // dummy
  double x;
  int i, j;

  
  // print header
  printf( "Binning analysis of time series\n\n" );

  // check command-line arguments
  if( 3!=argc ) {
    printf( "Usage: %s <file> <Nbins>\n", argv[0] );
    printf( "  file -- one-column file with time series\n" );
    printf( "  Nbins -- number of bins\n\n" );
    printf( "This program makes two passes and does not store data in memory.\n" );
    printf( "On the first pass the length of time series Ndat is determined.\n" );
    printf( "Ndat is decreased to the closest integer divisible by Nbins.\n" );
    printf( "On the second pass the data is binned with Ndat/Nbins data per bin.\n" );
    printf( "The mean and the error of the mean are calculated from the bins.\n" );
    printf( "As a byproduct this program outputs a file with\n" );
    printf( "binned data, as it may sometimes be needed for further analysis\n" );
    return 1;
  }

  
  // process command-line arguments
  strcpy( filename, argv[1] );
  Nbins = atoi( argv[2] );
  if( Nbins<1 || Nbins>1.e+9 ) {
    printf( "ERROR: Unreasonable number of bins Nbins = %d\n", Nbins );
    printf( "       Adjust Nbins.\n" );
    return 1;
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
  
  
  // do some checks and adjustments on the data length
  if( Ndat<Nbins ) {
    printf( "ERROR: Number of data points is less than the number of bins:\n" );
    printf( "       Ndat = %d < Nbins = %d\n", Ndat, Nbins );
    return 1;
  }
  i = Ndat%Nbins;
  if( 0!=i ) { // drop some number of points at the end
    printf( "WARNING: Ndat = %d is not divisible by Nbins = %d\n", Ndat, Nbins );
    Ndat -= i;
    printf( "         Adjusting to Ndat = %d\n", Ndat );
  }
  printf( "Total number of data to be processed: %d\n\n", Ndat );


  // prepare storage, set to 0
  Nperbin = Ndat / Nbins;
  data_bin = (double*)calloc( Nbins, sizeof(double) );
  
  printf( "Number of bins: %d\n", Nbins );
  printf( "Number of data per bin: %d\n\n", Nperbin );
  
  // Second pass: read the data, add to bins, discard
  printf( "Second pass -- bin the data\n\n" );
  xtotal = 0; // accumulator for the total average
  x2total = 0; // accumulator for the naive variance of the mean
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
    // determine the bin
    j = i / Nperbin;
    // accumulate the binned average
    data_bin[j] += x;
    // accumulate the total average and variance
    xtotal += x;
    x2total += x*x;
  }
  fclose( fp );


  // normalize everyone
  for( i=0; i<Nbins; i++ ) {
    data_bin[i] /= Nperbin;
  }
  xtotal /= Ndat;
  x2total /= Ndat;


  // naive error analysis
  xerror = sqrt( ( x2total - xtotal*xtotal ) / Ndat );
  printf( "Naive error analysis:\n" );
  printf( "x +/- dx = %.16g +/- %.16g\n\n", xtotal, xerror );

  
  // binned error analysis
  xtotal = 0; // the mean should be the same, this is just a consistency check
  for( i=0; i<Nbins; i++ ) {
    xtotal += data_bin[i];
  }
  xtotal /= Nbins;
  xerror = 0;
  for( i=0; i<Nbins; i++ ) {
    x = data_bin[i] - xtotal;
    xerror += x*x;
  }
  xerror /= Nbins;
  xerror /= ( Nbins - 1 );
  xerror = sqrt( xerror );
  printf( "Binned error analysis:\n" );
  printf( "x +/- dx = %.16g +/- %.16g\n", xtotal, xerror );


  // output bins
  fp = fopen( "data_bin.d", "wt" );
  for( i=0; i<Nbins; i++ ) {
    // adjust output formatting here if it does not look nice
    fprintf( fp, "%.16g\n", data_bin[i]  );
  }
  fclose( fp );
  
  
  // free up storage
  free( data_bin );
  
  return 0;
}
