// Calculate the integrated autocorrelation time for a given
// time series with the window method, Berg (2003).
// This program reads all data into memory,
// then calculates the autocorrelation function
// and the integrated autocorrelation time from it.
// The errorbars are estimated with jackknife.
// Relies on GSL.
//
// Alexei Bazavov, Thomas Chuna, 2018

// standard includes
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// GSL includes
#include <gsl/gsl_statistics.h>



// get the autocorrelation function at time it
// input:
// it - time separatation, e.g. x(t)x(t+it)
// Ndat - number of data
// data - array with data
// output:
// autocorrelation function C(it)
double autocorf( int it, int Ndat, double *data ) {
  double mean, af = 0;
  int i, nn;

  // get the mean
  mean = gsl_stats_mean(data, 1, Ndat);

  // cut the data so we do not get out of range
  nn = Ndat - it;

  for( i=0; i<nn; i++ )
    af += ( data[i] - mean ) * ( data[i+it] - mean );

  // bias correction
  af /= nn;
  af *= Ndat / (Ndat - 1.);

  return af;
}


// get the autocorrelation function at time it
// in jackknife bins
// input:
// it - time separatation, e.g. x(t)x(t+it)
// Ndat - number of data
// data - array with data
// Nbins - number of jackknife bins
// output:
// autocorrelation function C(it) in acorj array
void autocorj( int it, int Ndat, double *data,
               int Nbins, double *acorj ) {
  double mean, *work, sum, f;
  int i, nn, nperbin, ibins, i1, i2;

  mean = gsl_stats_mean(data, 1, Ndat);

  // cut the data so we do not get out of range
  nn = Ndat - it;
  nperbin = nn / Nbins;

  // temporary storage
  work = (double*)malloc( Nbins*sizeof(double) );

  // get the values in the usual bins and the total
  sum = 0;
  for( ibins=0; ibins<Nbins; ibins++ ) {
    work[ibins] = 0;
    // bounds of the bin
    i1 = ibins*nperbin;
    i2 = (ibins+1)*nperbin;

    for( i=i1; i<i2; i++ )
      work[ibins] += ( data[i] - mean ) * ( data[i+it] - mean );

    work[ibins] /= nperbin;
    sum += work[ibins];
  }

  // create jackknife bins - subtract from the total
  // and bias correct
  f = 1. / ( Nbins - 1 );
  f *= Ndat / ( Ndat - 1.0 );
  for( ibins=0; ibins<Nbins; ibins++ )
    acorj[ibins] = f * ( sum - work[ibins] );

  free( work );
}



int main( int argc, char *argv[] ) {
  int Nt;     // length of the window
  int Nbins;  // number of bins for jackknife analysis
  int Ndat;   // length of input file
  // storage
  double *data, *acorf, **acorj, **acorj_n, *acint, **acintj;
  // means and errors
  double afmean, anmean, acmean, afe, ane, ace, bias;
  // files
  FILE *fp, *fq;
  char *af_file, *ac_file, *infile;
  // dummy
  double x;
  int i, ibins;


  // print header
  printf( "Integrated autocorrelation time for a time series\n\n" );
  
  // check command-line arguments
  if( 6!=argc ) {
    printf( "Usage: %s <acorf_file> <acint_file> <data_file> <Nt> <Nbins>\n", argv[0] );
    printf( "  acorf_file -- file to output the autocorrelation function\n" );
    printf( "  acint_file -- file to output the integrated autocorrelation time\n" );
    printf( "  data_file -- one-column file with time series data\n" );
    printf( "  Nt -- time window\n" );
    printf( "  Nbins -- number of jackknife bins\n\n" );
    printf( "This program makes two passes.\n" );
    printf( "On the first pass the number of data is determined.\n" );
    printf( "On the second pass the data is read in.\n" );
    return 1;
  }

  // process command-line arguments
  af_file = argv[1];
  ac_file = argv[2];
  infile = argv[3];
  Nt = atoi(argv[4]);
  Nbins = atoi(argv[5]);

  // check if the input file can be read
  fp = fopen( infile, "rt" );
  if( NULL==fp ) {
    fprintf( stderr, "ERROR: Input file %s cannot be read\n", infile );
    return 1;
  }


  // First pass: determine the number of data in the file
  printf( "First pass -- processing data file: %s\n", infile );
  Ndat = 0;
  while( 1==fscanf( fp, "%lf", &x ) ) Ndat++;
  fclose( fp );

  printf( "Total number of data in the file: %d\n", Ndat );
  printf( "Number of bins: %d\n", Nbins );
  printf( "Time window: %d\n", Nt );
  printf( "\n" );

  // do some checks
  if( Ndat<Nbins ) {
    printf( "ERROR: Number of data points is less than the number of bins:\n" );
    printf( "       Ndat = %d < Nbins = %d\n", Ndat, Nbins );
    printf( "       Choose smaller Nbins\n" );
    return 1;
  }
  if( Ndat/Nbins<Nt ) {
    printf( "ERROR: Number of data points per bin is less than the time window:\n" );
    printf( "       Ndat/Nbins = %d < Nt = %d\n", Ndat/Nbins, Nt );
    printf( "       Cannot estimate integrated autocorrelation time\n" );
    printf( "       Choose smaller Nt\n" );
    return 1;
  }


  // Second pass: read the data
  printf( "Second pass -- reading in the data\n\n" );
  fp = fopen( infile, "rt" );
  if( NULL==fp ) {
    fprintf( stderr, "ERROR: Input file %s cannot be read\n", infile );
    return 1;
  }

  // prepare storage for data
  data = (double*)malloc( Ndat*sizeof(double) );
  
  for( i=0; i<Ndat; i++ ) {
    if( 1!=fscanf( fp, "%lf", &data[i] ) ) {
      printf( "ERROR: Unexpected end of file %s", infile );
      fclose( fp );
      free( data );
      return 1;
    }
  }
  fclose( fp );

  
  // prepare storage for analysis
  acorf   = (double* )malloc( (Nt+1)*sizeof(double ) );
  acorj   = (double**)malloc( (Nt+1)*sizeof(double*) );
  acorj_n = (double**)malloc( (Nt+1)*sizeof(double*) );
  acint   = (double* )malloc( (Nt+1)*sizeof(double ) );
  acintj  = (double**)malloc( (Nt+1)*sizeof(double*) );
  for( i=0; i<=Nt; i++) {
    acorj[i]   = (double*)malloc( Nbins*sizeof(double) );
    acorj_n[i] = (double*)malloc( Nbins*sizeof(double) );
    acintj[i]  = (double*)malloc( Nbins*sizeof(double) );
  }


  printf( "Calculating the autocorrelation function\n\n" );
  for( i=0; i<=Nt; i++ )
  {
    // naive version for bias estimation
    acorf[i] = autocorf( i, Ndat, data );
    // jackknife autocorrelation function
    autocorj( i, Ndat, data, Nbins, acorj[i] );
  }


  printf( "Calculating the integrated autocorrelation time\n\n" );
  acint[0] = 1;
  for( ibins=0; ibins<Nbins; ibins++ ) {
    acintj[0][ibins] = 1;
    acorj_n[0][ibins] = 1;
  }
  for( i=1; i<=Nt; i++ ) {
    acint[i] = acint[i-1] + 2*acorf[i]/acorf[0];
    for( ibins=0; ibins<Nbins; ibins++ ) {
      // normalize the autocorrelation function
      acorj_n[i][ibins] = acorj[i][ibins]/acorj[0][ibins];
      // integrated autocorrelation time
      acintj[i][ibins] = acintj[i-1][ibins] + 2*acorj_n[i][ibins];
    }
  }


  // output the autocorrelation function and
  // the integrated autocorrelation time
  fp = fopen( af_file, "wt" );
  fq = fopen( ac_file, "wt" );
  for( i=0; i<=Nt; i++ ) {
    // get the mean
    afmean = gsl_stats_mean( acorj[i], 1, Nbins );
    anmean = gsl_stats_mean( acorj_n[i], 1, Nbins );
    acmean = gsl_stats_mean( acintj[i], 1, Nbins );
    // get the jackknife error
    afe = 0;
    ane = 0;
    ace = 0;
    for( ibins=0; ibins<Nbins; ibins++ ) {
      afe += ( acorj[i][ibins] - afmean ) * ( acorj[i][ibins] - afmean );
      ane += ( acorj_n[i][ibins] - anmean ) * ( acorj_n[i][ibins] - anmean );
      ace += ( acintj[i][ibins] - acmean ) * ( acintj[i][ibins] - acmean );
    }
    afe = sqrt( (afe*(Nbins-1) ) / Nbins );
    ane = sqrt( (ane*(Nbins-1) ) / Nbins );
    ace = sqrt( (ace*(Nbins-1) ) / Nbins );
    // bias
    bias = 100 * fabs( (acint[i] - acmean) / acint[i] );
    // output on the screen:
    // time, naive tau, jackknife tau, jackknife error, bias
    printf( "i=%6d   acint: %14.8f%14.8f%14.8f%14.4f\n", i,
            acint[i], acmean, ace, bias );
    // store the autocorrelation function
    fprintf( fp, "%d %.12g %.12g %.12g %.12g\n",
             i, afmean, afe, anmean, ane );
    // store the integrated autocorrelation time
    fprintf( fq, "%d %.12g %.12g\n", i, acmean, ace );
  }
  fclose( fp );
  fclose( fq );
  
  printf( "\n" );
  printf( "Output written to %s and %s\n", af_file, ac_file );

  // free up storage
  for( i=0; i<=Nt; i++) {
    free( acorj[i] );
    free( acorj_n[i] );
    free( acintj[i] );
  }
  free( data );
  free( acorf );
  free( acorj );
  free( acorj_n );
  free( acint );
  free( acintj );

  return 0;
}
