#!/bin/bash

ens_name="1664b704115x181411"
masses=("0.0146")
mas_len=${#masses[@]}

prefix="nlpi"

xq_arr=("1980")
#sinks_arr=("PION_5" "PION_i5" "PION_i" "PION_s")
sinks_arr=("PION_05" "PION_ij" "PION_i0" "PION_0")
mom_arr=("p000")


src_label="eowfw"

first=101
last=1100

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

python format_corrfitter_one.py <<EOF
${ens_name}a
${prefix}${mom}${src_label}${ens_name}xq${xq}_m${mass1}m${mass2}${sinks}
${first}
${last}
EOF

done #xq

done # m1

done # sinks

done # momenta

