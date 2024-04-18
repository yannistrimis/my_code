#!/bin/bash

awk '$1 == "w" && $2 == "clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > swc_xiR_4.data
awk '$1 == "w" && $2 == "i_clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > swi_xiR_4.data
awk '$1 == "w" && $2 == "wilson" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > sww_xiR_4.data
awk '$1 == "w" && $2 == "symanzik" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > sws_xiR_4.data
awk '$1 == "s" && $2 == "clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > ssc_xiR_4.data
awk '$1 == "s" && $2 == "i_clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > ssi_xiR_4.data
awk '$1 == "s" && $2 == "wilson" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > ssw_xiR_4.data
awk '$1 == "s" && $2 == "symanzik" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > sss_xiR_4.data
# awk '$1 == "z" && $2 == "clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > szc_xiR_4.data
# awk '$1 == "z" && $2 == "i_clover" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > szi_xiR_4.data
# awk '$1 == "z" && $2 == "wilson" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > szw_xiR_4.data
# awk '$1 == "z" && $2 == "symanzik" { print $5,$7,$10,$12 }' tuning_schemes_xiR_4.data  > szs_xiR_4.data

cat <<EOF > betafile.data
6.9
7.0
7.1
7.2
7.3
EOF

for file in ???_xiR_4.data
do

paste betafile.data ${file} > beta_${file}

done
