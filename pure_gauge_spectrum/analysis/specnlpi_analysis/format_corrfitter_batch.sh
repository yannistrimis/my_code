#!/bin/bash

ens_name="1296b575x3136"
masses=("0.1")
mas_len=${#masses[@]}

prefix="nlpi"

xq_arr=("283")
mom_arr=("p000")

src_label="eowfw"

#sinks_arr=("PION_5" "PION_i5" "PION_i" "PION_s" "PION_05" "PION_ij" "PION_i0" "PION_0")
sinks_arr=("PION_5" "PION_i5" "PION_i" "PION_s")

first=101
last=500

for mom in ${mom_arr[@]}
do
echo "${mom}"

for sinks in ${sinks_arr[@]}
do

echo "${sinks}"

for (( m1=0 ; m1<${mas_len} ; m1++ ));
do

mass1=${masses[$m1]}
mass2=${mass1}

for xq in "${xq_arr[@]}"
do

python3 format_corrfitter_one.py <<EOF
${ens_name}p
${prefix}${mom}${src_label}${ens_name}xq${xq}_m${mass1}m${mass2}${sinks}
${first}
${last}
EOF

done #xq

done # m1

done # sinks

done # momenta

