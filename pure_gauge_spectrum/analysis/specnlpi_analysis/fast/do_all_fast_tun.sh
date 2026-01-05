#!/bin/bash

nt=32 # DON'T FORGET TO CHANGE !!!

ens_name="1664b704115x181411zl"
masses=("0.073" "0.0073" "0.0146" "0.1022" "0.0292")
mas_len=${#masses[@]}

prefix="hisqtunz"

xq_arr=("1980" )
sinks_arr=("PION_5")
mom_arr=("p000")
#mom_arr=("p100" "p110")

source1="CORNER"
#source1="CORNER/momentum"
source2="CORNER"

src_label="cw"

sinkop1="identity"
sinkop2="identity"

first=101
last=600

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
