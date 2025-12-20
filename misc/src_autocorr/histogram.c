// Make a histogram of the data.
// This program makes two passes:
// 1) determine the number of entries in the data file and
//    the min/max values in the data
// 2) accumulate the histogram
//
// Alexei Bazavov, 2018

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>



int main( int argc, char *argv[] ) {
  int Nbins, Ndat, Nactual, i, ind;
  char filename_hist[1024];
  char filename_data[1024];
  double xmin, xmax, x, data_xmin=0, data_xmax=0, xstep, *hist;
  FILE *fp;
  
  // print header
  printf( "Histogram the data\n\n" );
  
  
  // process the command-line arguments
  if( !( 3==argc // filenames only
      || 4==argc  // filenames and number of bins
      || 6==argc // filenames, number of bins and min/max
        ) ) {
    printf( "Usage: %s <hist_file> <data_file> [<Nbins> [<xmin> <xmax>]]\n", argv[0] );
    printf( "  hist_file -- resulting file with the histogram\n" );
    printf( "  filename -- one-column file with the data\n" );
    printf( "  Nbins -- number of histogram bins\n" );
    printf( "  xmin, xmax -- boundaries of the histogram\n" );
    return 1;
  }
  strcpy( filename_hist, argv[1] );
  strcpy( filename_data, argv[2] );
  if( argc>3 ) {
    Nbins = atoi( argv[3] );
  }
  else { // default if not specified
    Nbins = 10;
  }
  printf( "Number of bins: %d\n", Nbins );
  if( argc>4 ) {
    xmin = atof( argv[4] );
    xmax = atof( argv[5] );
  }

  
  // check if the input file can be read
  fp = fopen( filename_data, "rt" );
  if( NULL==fp ) {
    printf( "Input file %s cannot be read\n", filename_data );
    return 1;
  }
  
  // First pass: determine the number data in the file
  printf( "Processing data file: %s\n", filename_data );
  Ndat = 0;
  while( 1==fscanf( fp, "%lf", &x ) ) {
    if( 0==Ndat ) { // set min/max from the first record
      data_xmin = x;
      data_xmax = x;
    }
    else { // update min/max
      if( x<data_xmin ) data_xmin = x;
      if( x>data_xmax ) data_xmax = x;
    }
    Ndat++;
  }
  
  printf( "Total number of data in %s: %d\n\n", filename_data, Ndat );
  printf( "Data minimum: %20.16g\n", data_xmin );
  printf( "Data maximum: %20.16g\n", data_xmax );
  fclose(fp);

  if( argc<6 ) { // min/max are set from the data
    printf( "Histogram bounds are set from data\n" );
    xmin = data_xmin;
    // to make sure the last point is not dropped
    xmax = data_xmax*1.00001;
  }
  printf( "Histogram bounds: %20.16g %20.16g\n", xmin, xmax );

  
  // initialize the histogram parameters and storage array
  xstep = ( xmax - xmin ) / Nbins;
  hist = (double*)malloc( Nbins*sizeof(double) );
  for( i=0; i<Nbins; i++ ) hist[i] = 0;

  
  // Second pass: accumulate the histogram
  fp = fopen( filename_data, "rt" );
  Nactual = 0;
  for( i=0; i<Ndat; i++ ) {
    if( 1!=fscanf( fp, "%lf", &x ) ) {
      printf( "ERROR: Unexpected end of file %s", filename_data );
      fclose( fp );
      return 1;
    }

    if( xmin<=x && x<xmax ) { // check if in the histogram range
      ind = (int)( (x-xmin) / xstep );
      hist[ind] += 1;
      Nactual++;
    }
  }
  printf( "Number of points dropped from histogram: %d\n", Ndat-Nactual );

  // normalize the histogram
  for( i=0; i<Nbins; i++ ) hist[i] /= ( xstep * Nactual );


  // output histogram for gnuplot
  fp = fopen( filename_hist, "wt" );
  for( i=0; i<Nbins; i++ ) {
    x = xmin + i*xstep;
    fprintf( fp, "%20.16g %g\n", x, 0. );
    fprintf( fp, "%20.16g %g\n", x, hist[i] );
    x = xmin + (i+1)*xstep;
    fprintf( fp, "%20.16g %g\n", x, hist[i] );
    if( i==Nbins-1 ) {
      fprintf( fp, "%20.16g %g\n", x, 0. );
    }
  }
  // free storage
  free( hist );
  
  return 0;
}
