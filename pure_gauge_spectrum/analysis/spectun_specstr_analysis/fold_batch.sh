#!/bin/bash
nt=32 # DON'T FORGET TO CHANGE !!!

ens_name="1632b684652x107865"
stream="a"
masses=("0.06")
mas_len=${#masses[@]}

prefix="hisqtun"

xq_arr=("1000" "1050" "1100" "1150")
sinks_arr=("PION_5")

mom_arr=("p000" "p100" "p110")

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

