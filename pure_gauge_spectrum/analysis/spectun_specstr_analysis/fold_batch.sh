#!/bin/bash
nt=64 # DON'T FORGET TO CHANGE !!!

ens_name="1664b693563x180060"
stream="a"
masses=("0.08" "0.09" "0.1" "0.11")
mas_len=${#masses[@]}

prefix="hisqstr"

xq_arr=("1985")
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

python3 fold_one.py <<EOF
${nt}
${ens_name}${stream}
averspec${prefix}${mom}${src_label}${ens_name}xq${xq}_m${mass1}m${mass2}${sinks}
${i_file}
foldspec${prefix}${mom}${src_label}${ens_name}xq${xq}_m${mass1}m${mass2}${sinks}
EOF

done #xq

done # m1

done # i_file

done # sinks

done # momenta

