#!/bin/bash

ens_name="1632b681823x100000"
stream="a"
masses=("0.03" "0.05" "0.07" "0.09")
mas_len=${#masses[@]}

prefix="naivtun"

xq_arr=("1000")
sinks_arr=("PION_5")

mom_arr=("p000")

src_label="cw"

for mom in ${mom_arr[@]}
do
echo "${mom}"

for sinks in ${sinks_arr[@]}
do

echo "${sinks}"

for i_file in {101..500..1}
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
