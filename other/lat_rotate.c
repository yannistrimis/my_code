/* Utility to read in MILC SU(3) lattice saved
   with dimensions (x,y,z,t) and permute the site order
   and link order per site as (t,x,y,z)
   AB 2012/06/25 */


#include <stdio.h>
#include <stdlib.h>



// constants
#define HEADER_SIZE 96
#define SIZE_CHAR 1
#define SIZE_INT 4
#define SIZE_FLOAT 4
#define SIZE_DOUBLE 8
#define GAUGE_VERSION_NUMBER 0x4e87 /* decimal 20103 Versions 5-7 */
#define CSUM_OFFSET 88
#define LINK_SIZE 72
#define RECORD_SIZE (4*LINK_SIZE)




// check, =1 if big-endian architecture, =0 for little-endian
int big_endian() {
  union  {
    long l;
    char c[sizeof (long)];
  } u;
  u.l = 1;
  return (u.c[sizeof (long) - 1] == 1);
}


/* For doing byte reversal on 32-bit words */
void byterevn(int w[], int n)
{
  register int old, newv;
  int j;

  for(j=0; j<n; j++)
    {
      old = w[j];
      newv = old >> 24 & 0x000000ff;
      newv |= old >> 8 & 0x0000ff00;
      newv |= old << 8 & 0x00ff0000;
      newv |= old << 24 & 0xff000000;
      w[j] = newv;
    }
} /* byterevn */


/* Do byte reversal on n contiguous 64-bit words */
void byterevn64(int w[], int n)
{
  int tmp;
  int j;

  /* First swap pairs of 32-bit words */
  for(j=0; j<n; j++){
    tmp = w[2*j];
    w[2*j] = w[2*j+1];
    w[2*j+1] = tmp;
  }

  /* Then swap bytes in 32-bit words */
  byterevn(w, 2*n);
}







int main(int argc, char *argv[]) {

  int archi; // architecture type: =1 - big-endian, =0 - little-endian
  int lat_archi;
  FILE *fpin, *fpout;
  char header[HEADER_SIZE];
  int tmp, btmp, byterev_flag;
  int nx, ny, nz, nt, mx, my, mz, mt, csum29, csum31;
  int sum29, sum31, rank29, rank31;
  int i, ix, iy, iz, it, ff, jx, jy, jz, jt;
  unsigned int *val;
  char buffer[RECORD_SIZE], buffer2[RECORD_SIZE];
  long int rec_offset;

  // print header
  printf( "Flip MILC SU(3) lattice: (x,y,z,t) -> (t,x,y,z)\n" );

  // check command-line arguments
  if( argc != 3 ) {
    printf("Usage: %s <in file> <out file>\n",argv[0]);
    exit(1);
  }

  // determine host architecture
  archi = big_endian();
  printf( "Host architecture: " );
  if( archi ) {
    printf( "big-endian\n");
  }
  else {
    printf( "little-endian\n");
  }


  // determine sizes of int, float and double
  if( !( sizeof(char)==SIZE_CHAR && sizeof(int)==SIZE_INT
      && sizeof(float)==SIZE_FLOAT && sizeof(double)==SIZE_DOUBLE ) ) {
    printf( "Conversion requires sizeof(char)=%d, sizeof(int)=%d, sizeof(float)=%d, sizeof(double)=%d\n",
            SIZE_CHAR, SIZE_INT, SIZE_FLOAT, SIZE_DOUBLE);
    printf( "Cannot convert on this architecture\n" );
    exit(1);
  }


  // check input file
  printf( "Input file: %s\n", argv[1] );
  fpin = fopen( argv[1], "rb" );
  if( fpin==NULL ) {
    printf( "Cannot open %s\n", argv[1] );
    exit(1);
  }

  // read in header
  fread( (void*)header, SIZE_CHAR, HEADER_SIZE, fpin );

  // get magic number
  tmp  = *( (int*) ( (void*)header ) );
  btmp = *( (int*) ( (void*)header ) );
  byterevn( (void*)&btmp, 1 );

  // determine file validity and if byte reversal is needed
  if( tmp == GAUGE_VERSION_NUMBER ) {
    byterev_flag = 0;
  }
  else if( btmp == GAUGE_VERSION_NUMBER ) {
    byterev_flag = 1;
  }
  else {
    printf( "File %s is not a valid lattice file\n", argv[1] );
    fclose( fpin );
    exit(1);
  }

  // determine the architecture of the lattice file
  lat_archi = archi ^ byterev_flag;
  printf( "Lattice architecture: " );
  if( lat_archi ) {
    printf( "big-endian\n");
  }
  else {
    printf( "little-endian\n");
  }
  if( byterev_flag) {
    printf( "Byte reversal IS needed\n" );
  }
  else {
    printf( "Byte reversal is NOT needed\n" );
  }

  // get lattice check sums
  csum29 = *( (int*) (header + CSUM_OFFSET ) );
  csum31 = *( (int*) (header + CSUM_OFFSET + 4 ) );
  if( byterev_flag ) {
    byterevn( (void*)&csum29, 1 );
    byterevn( (void*)&csum31, 1 );
  }


  // get lattice dimensions
  nx = *( (int*) ( header+ 4 ) );
  if( byterev_flag ) byterevn( (void*)&nx, 1 );
  ny = *( (int*) ( header+ 8 ) );
  if( byterev_flag ) byterevn( (void*)&ny, 1 );
  nz = *( (int*) ( header+12 ) );
  if( byterev_flag ) byterevn( (void*)&nz, 1 );
  nt = *( (int*) ( header+16 ) );
  if( byterev_flag ) byterevn( (void*)&nt, 1 );

  printf( "Lattice dimensions: nx=%d ny=%d nz=%d nt=%d\n", nx, ny, nz, nt );

  printf( "Checksums: %x %x\n", csum29, csum31 );


  // open file for writing
  fpout = fopen( argv[2], "wb" );
  if( fpout==NULL ) {
    printf( "Cannot open file %s for writing\n", argv[2] );
    exit(1);
  }

  // permute lattice dimensions
  mx = nt; my = nx; mz = ny; mt = nz;

  // put new dimensions into header
  *( (int*) ( header+ 4 ) ) = mx;
  *( (int*) ( header+ 8 ) ) = my;
  *( (int*) ( header+12 ) ) = mz;
  *( (int*) ( header+16 ) ) = mt;
  // byte reverse if needed
  if( byterev_flag ) byterevn( (void*)(header+4), 4 );


  // write new header
  fwrite( (void*)header, SIZE_CHAR, HEADER_SIZE, fpout );


  // initialize checksums
  sum29 = 0; sum31 = 0;
  rank29 = 0; rank31 = 0;

  // loop on sites
  for( it=0; it<nt; it++ ) {
    for( iz=0; iz<nz; iz++ ) {
      for( iy=0; iy<ny; iy++ ) {
        for( ix=0; ix<nx; ix++ ) {
          // read link record
          ff = fread( (void*)buffer, SIZE_CHAR, RECORD_SIZE, fpin );
          if( ff!=RECORD_SIZE ) {
            printf( "End of file encountered  while reading %s\n", argv[2] );
            exit(1);
          }
          // byte reverse if needed
          if( byterev_flag ) byterevn( (void*)buffer, RECORD_SIZE/SIZE_INT );

          // evaluate checksums
          for( i=0; i < RECORD_SIZE/SIZE_INT; i++ ) {
            val = (unsigned int*) ( buffer + SIZE_INT*i );
            sum29 ^= (*val)<<rank29 | (*val)>>(32-rank29);
            sum31 ^= (*val)<<rank31 | (*val)>>(32-rank31);
            rank29++; if(rank29 >= 29)rank29 = 0;
            rank31++; if(rank31 >= 31)rank31 = 0;
          }

          // write the link record, do not care about byte reversing because
          // the output file will be overwritten anyway
          fwrite( (void*)buffer, SIZE_CHAR, RECORD_SIZE, fpout );
        } // ix
      } // iy
    } // iz
  } // it
  fclose( fpin );
  fclose( fpout );

  printf( "Checksums computed: %x %x", sum29, sum31 );
  if( csum29==sum29 && csum31==sum31 ) {
    printf( " OK\n" );
  }
  else {
    printf( " VIOLATED\n" );
    printf( "Cannot convert this lattice\n" );
    exit(1);
  }


  // second pass -- write sites and links in the new order

  fpin = fopen( argv[1], "rb" );
  fpout = fopen( argv[2], "rb+" );

  fseek( fpin, HEADER_SIZE, SEEK_SET );
  fseek( fpout, HEADER_SIZE, SEEK_SET );

  // initialize checksums
  sum29 = 0; sum31 = 0;
  rank29 = 0; rank31 = 0;

  // loop on sites of the flipped lattice, because new lattice need to be
  // written sequentially to get correct check sums
  for( jt=0; jt<mt; jt++ ) {
    for( jz=0; jz<mz; jz++ ) {
      for( jy=0; jy<my; jy++ ) {
        for( jx=0; jx<mx; jx++ ) {
          // permute back into old coordinates
          ix = jy; iy = jz; iz = jt; it = jx;

          // calculate offset in the file
          rec_offset = it;
          rec_offset = rec_offset * nz + iz;
          rec_offset = rec_offset * ny + iy;
          rec_offset = rec_offset * nx + ix;
          rec_offset *= RECORD_SIZE;
          rec_offset += HEADER_SIZE;

          // position output file pointer
          fseek( fpin, rec_offset, SEEK_SET );

          // read link record
          ff = fread( (void*)buffer, SIZE_CHAR, RECORD_SIZE, fpin );
          if( ff!=RECORD_SIZE ) {
            printf( "End of file encountered  while reading %s\n", argv[2] );
            exit(1);
          }
          // byte reverse if needed
          if( byterev_flag ) byterevn( (void*)buffer, RECORD_SIZE/SIZE_INT );

          // copy links to a buffer in a different order
          for( i=0; i<LINK_SIZE; i++ ) {
            buffer2[ LINK_SIZE   + i ] = buffer[               i ];
            buffer2[ LINK_SIZE*2 + i ] = buffer[ LINK_SIZE   + i ];
            buffer2[ LINK_SIZE*3 + i ] = buffer[ LINK_SIZE*2 + i ];
            buffer2[               i ] = buffer[ LINK_SIZE*3 + i ];
          }

          // evaluate checksums
          for( i=0; i < RECORD_SIZE/SIZE_INT; i++ ) {
            val = (unsigned int*) ( buffer2 + SIZE_INT*i );
            sum29 ^= (*val)<<rank29 | (*val)>>(32-rank29);
            sum31 ^= (*val)<<rank31 | (*val)>>(32-rank31);
            rank29++; if(rank29 >= 29)rank29 = 0;
            rank31++; if(rank31 >= 31)rank31 = 0;
          }

          // byte reverse if needed
          if( byterev_flag ) byterevn( (void*)buffer2, RECORD_SIZE/SIZE_INT );

          // write the link record
          fwrite( (void*)buffer2, SIZE_CHAR, RECORD_SIZE, fpout );
        } // jx
      } // jy
    } // jz
  } // jt

  printf( "Checksums permuted: %x %x\n", sum29, sum31 );

  // byte reverse checksums if needed
  if( byterev_flag ) {
    byterevn( (void*)&sum29, 1 );
    byterevn( (void*)&sum31, 1 );
  }

  // position pointer and write checksums into file
  fseek( fpout, CSUM_OFFSET, SEEK_SET );
  fwrite( (void*)&sum29, 1, SIZE_INT, fpout );
  fwrite( (void*)&sum31, 1, SIZE_INT, fpout );

  fclose( fpin );
  fclose( fpout );

  printf( "Successfully flipped lattice and wrote %s\n", argv[2] );

  return 0;
  
}
