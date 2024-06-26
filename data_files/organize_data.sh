#!/bin/bash

xiR="8"

awk '$1 == "w" && $2 == "clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > swc_xiR_${xiR}.data
#awk '$1 == "w" && $2 == "i_clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > swi_xiR_${xiR}.data
#awk '$1 == "w" && $2 == "wilson" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > sww_xiR_${xiR}.data
#awk '$1 == "w" && $2 == "symanzik" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > sws_xiR_${xiR}.data
#awk '$1 == "s" && $2 == "clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > ssc_xiR_${xiR}.data
#awk '$1 == "s" && $2 == "i_clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > ssi_xiR_${xiR}.data
#awk '$1 == "s" && $2 == "wilson" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > ssw_xiR_${xiR}.data
#awk '$1 == "s" && $2 == "symanzik" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > sss_xiR_${xiR}.data
#awk '$1 == "z" && $2 == "clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > szc_xiR_${xiR}.data
#awk '$1 == "z" && $2 == "i_clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > szi_xiR_${xiR}.data
#awk '$1 == "z" && $2 == "wilson" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > szw_xiR_${xiR}.data
#awk '$1 == "z" && $2 == "symanzik" { print $5,$7,$10,$12 }' tuning_schemes_xiR_${xiR}.data  > szs_xiR_${xiR}.data

cat <<EOF > betafile.data
7.22
7.26
7.30
EOF

for file in ???_xiR_${xiR}.data
do

paste betafile.data ${file} > beta_${file}

done
