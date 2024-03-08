#!/bin/bash

awk '$1 == "w" && $2 == "clover" { print $5,$7,$10,$12 }' tuning_schemes.data  > swc.data
awk '$1 == "w" && $2 == "wilson" { print $5,$7,$10,$12 }' tuning_schemes.data  > sww.data
awk '$1 == "w" && $2 == "symanzik" { print $5,$7,$10,$12 }' tuning_schemes.data  > sws.data
awk '$1 == "s" && $2 == "clover" { print $5,$7,$10,$12 }' tuning_schemes.data  > ssc.data
awk '$1 == "s" && $2 == "wilson" { print $5,$7,$10,$12 }' tuning_schemes.data  > ssw.data
awk '$1 == "s" && $2 == "symanzik" { print $5,$7,$10,$12 }' tuning_schemes.data  > sss.data
awk '$1 == "z" && $2 == "clover" { print $5,$7,$10,$12 }' tuning_schemes.data  > szc.data
awk '$1 == "z" && $2 == "i_clover" { print $5,$7,$10,$12 }' tuning_schemes.data  > szi.data
awk '$1 == "z" && $2 == "wilson" { print $5,$7,$10,$12 }' tuning_schemes.data  > szw.data
awk '$1 == "z" && $2 == "symanzik" { print $5,$7,$10,$12 }' tuning_schemes.data  > szs.data

cat <<EOF > betafile.data
6.9
7.0
7.1
7.2
7.3
EOF

for file in ???.data
do

paste betafile.data ${file} > beta_${file}

done
