#!/bin/bash

nt=128 # DON'T FORGET TO CHANGE !!!

ens_name="16128b719156x348992a"
masses=("0.01446")
mas_len=${#masses[@]}

prefix="hisqnlpi"

xq_arr=("4000")
#sinks_arr=("PION_s" "PION_i5" "PION_i" "PION_s")
sinks_arr=("PION_05" "PION_ij" "PION_i0" "PION_0")
mom_arr=("p000")

source1="even_and_odd_wall"
#source2="even_and_odd_wall/FUNNYWALL1"
source2="even_and_odd_wall/FUNNYWALL2"

src_label="eowfw"

sinkop1="identity"
sinkop2="identity"

first=101
last=1700

# output_dir="/home/trimis/spec_data"
# data_dir="/home/trimis/spec_data"

output_dir="/home/trimisio/all/spec_data"
data_dir="/home/trimisio/all/spec_data"

# output_dir="/home/yannis/Physics/LQCD/spec_data"
# data_dir="/home/yannis/Physics/LQCD/spec_data"

for mom in ${mom_arr[@]}
do
echo "${mom}"

for sinks in "${sinks_arr[@]}"
do
echo "${sinks}"

for (( m1=0 ; m1<${mas_len} ; m1++ ));
do

mass1=${masses[$m1]}
mass2=${mass1}

for xq in "${xq_arr[@]}"
do


correlatordata_name="${data_dir}/l${ens_name}/${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}.specdata"

if [ -f "${correlatordata_name}" ]
then
rm ${correlatordata_name}
fi


for (( i_file=${first} ; i_file<=${last} ; i_file++ ));
do

echo "    ${i_file}"

python3 do_all_one.py <<EOF
${ens_name}
spec${prefix}${ens_name}_xq${xq}
${i_file}
${mom}
${mass1}
${mass2}
${source1}
${source2}
${sinkop1}
${sinkop2}
${sinks}
${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}
${output_dir}
${data_dir}
${nt}
EOF

done #i_file

done #xq

done #m1

done #sinks

done #mom
