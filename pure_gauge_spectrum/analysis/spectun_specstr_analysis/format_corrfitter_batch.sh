#!/bin/bash

ens_name="1632b671789x100000"
stream="a"
masses=("0.06" "0.07" "0.08" "0.09" "0.1")
mas_len=${#masses[@]}

prefix="hisqtun"

xq_arr=("1000")
sinks_arr=("PION_5")

mom_arr=("p000")

src_label="cw"

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
${ens_name}${stream}
${prefix}${mom}${src_label}${ens_name}xq${xq}_m${mass1}m${mass2}${sinks}
${first}
${last}
EOF

done #xq

done # m1

done # sinks

done # momenta

