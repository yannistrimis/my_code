#!/bin/bash

xiR="4"

awk '$1 == "w" && $2 == "clover" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > swc_xiR_${xiR}.dat
awk '$1 == "w" && $2 == "i_clover" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > swi_xiR_${xiR}.dat
awk '$1 == "w" && $2 == "wilson" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > sww_xiR_${xiR}.dat
awk '$1 == "w" && $2 == "symanzik" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > sws_xiR_${xiR}.dat
awk '$1 == "s" && $2 == "clover" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > ssc_xiR_${xiR}.dat
awk '$1 == "s" && $2 == "i_clover" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > ssi_xiR_${xiR}.dat
awk '$1 == "s" && $2 == "wilson" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > ssw_xiR_${xiR}.dat
awk '$1 == "s" && $2 == "symanzik" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > sss_xiR_${xiR}.dat
awk '$1 == "z" && $2 == "clover" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > szc_xiR_${xiR}.dat
awk '$1 == "z" && $2 == "i_clover" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > szi_xiR_${xiR}.dat
awk '$1 == "z" && $2 == "wilson" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > szw_xiR_${xiR}.dat
awk '$1 == "z" && $2 == "symanzik" { print $5,$7,$10,$12 }' schemes_xiR_${xiR}.dat  > szs_xiR_${xiR}.dat

cat <<EOF > betafile.dat
6.90
7.00
7.10
7.20
7.30
EOF

for file in ???_xiR_${xiR}.dat
do

paste betafile.dat ${file} > beta_${file}

done
