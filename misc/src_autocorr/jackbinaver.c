// Jacknife analysis of jackknife binned data.
// This program makes two passes to determine the number of data entries.
// Then it read the jackknife bins and calculates
// mean and the error bar of the mean.
//
// Alexei Bazavov, 2018


// standard includes
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>



// MAIN block
int main( int argc, char *argv[] ) {
  // inputs
  char filename[1024];
  FILE *fp;
  // auxiliary
  int Nbins; // number of jackknife bins
  double *data_jack; // linear and jackknife bins
  double xtotal, xerror; // accumulators
  // dummy
  double x;
  int i;

  
  // print header
  printf( "Jackknife averaging of jackknife binned data\n\n" );

  // check command-line arguments
  if( 2!=argc ) {
    printf( "Usage: %s <file>\n", argv[0] );
    printf( "  file -- one-column file with jackknife bins\n\n" );
    printf( "This program makes two passes.\n" );
    printf( "On the first pass the number of bins Nbins is determined.\n" );
    printf( "On the second pass the data is read in.\n" );
    printf( "The jackknife mean and the error of the mean are calculated.\n" );
    return 1;
  }

  
  // process command-line arguments
  strcpy( filename, argv[1] );
  
  // check if the input file can be read
  fp = fopen( filename, "rt" );
  if( NULL==fp ) {
    fprintf( stderr, "ERROR: Input file %s cannot be read\n", filename );
    return 1;
  }

  
  // First pass: determine the number of data in the file
  printf( "First pass -- processing data file: %s\n", filename );
  Nbins = 0;
  while( 1==fscanf( fp, "%lf", &x ) ) Nbins++;
  fclose( fp );
  
  printf( "Total number of jackknife bins in the file: %d\n\n", Nbins );
  

  // prepare storage, set to 0
  data_jack= (double*)calloc( Nbins, sizeof(double) );
  

  // Second pass: read the data in
  printf( "Second pass -- read in the jackknife bins\n\n" );
  fp = fopen( filename, "rt" );
  if( NULL==fp ) {
    fprintf( stderr, "ERROR: Input file %s cannot be read\n", filename );
    return 1;
  }
  for( i=0; i<Nbins; i++ ) {
    // get the data
    if( 1!=fscanf( fp, "%lf", &x ) ) {
      printf( "ERROR: Unexpected end of file %s", filename );
      fclose( fp );
      return 1;
    }
    data_jack[i] = x;
  }
  fclose( fp );


  // jackknife error analysis
  xtotal = 0; // the mean
  for( i=0; i<Nbins; i++ ) {
    xtotal += data_jack[i];
  }
  xtotal /= Nbins;
  xerror = 0;
  for( i=0; i<Nbins; i++ ) {
    x = data_jack[i] - xtotal;
    xerror += x*x;
  }
  xerror *= ( Nbins - 1 );
  xerror /= Nbins;
  xerror = sqrt( xerror );
  printf( "Jackknife error analysis:\n" );
  printf( "x +/- dx = %.16g +/- %.16g\n", xtotal, xerror );


  // free up storage
  free( data_jack );
  
  return 0;
}
