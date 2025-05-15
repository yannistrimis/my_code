#!/bin/bash

ens_name="1632f2b5425m0375xig15xiq15"
stream="a"
masses=("0.0375")
mas_len=${#masses[@]}

prefix="naivnlpi"

xq_arr=("15")
mom_arr=("p000")

src_label="eowfw"

#sinks_arr=("PION_5" "PION_i5" "PION_i" "PION_s" "PION_05" "PION_ij" "PION_i0" "PION_0")
sinks_arr=("PION_5" "PION_05")

for mom in ${mom_arr[@]}
do
echo "${mom}"

for sinks in ${sinks_arr[@]}
do

echo "${sinks}"

for i_file in {201..600..1}
do

echo "    ${i_file}"

for (( m1=0 ; m1<${mas_len} ; m1++ ));
do

mass1=${masses[$m1]}
mass2=${mass1}

for xq in "${xq_arr[@]}"
do

python3 aver_one.py <<EOF
${ens_name}${stream}
cleanspec${prefix}${mom}${src_label}${ens_name}xq${xq}_m${mass1}m${mass2}${sinks}
${i_file}
averspec${prefix}${mom}${src_label}${ens_name}xq${xq}_m${mass1}m${mass2}${sinks}
EOF

done #xq

done # m1

done # i_file

done # sinks

done # momenta
