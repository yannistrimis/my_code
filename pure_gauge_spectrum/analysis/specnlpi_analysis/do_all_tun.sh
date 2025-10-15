#!/bin/bash

nt=32 # DON'T FORGET TO CHANGE !!!

ens_name="1632b687348x115792a"
masses=("0.05" "0.07" "0.09")
mas_len=${#masses[@]}

prefix="hisqtun"

xq_arr=("100" "120" "140")
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

# output_dir="/home/trimisio/all/spec_data"
# data_dir="/home/trimisio/all/spec_data"


output_dir="/home/trimis/spec_data"
data_dir="/home/trimis/spec_data"

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

for (( i_file=${first} ; i_file<=${last} ; i_file++ ));
do

echo "    ${i_file}"

python3 clean_one.py <<EOF
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
cleanspec${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}
${output_dir}
${data_dir}
EOF



python3 aver_one.py <<EOF
${ens_name}
cleanspec${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}
${i_file}
averspec${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}
${data_dir}
EOF

rm ${data_dir}/l${ens_name}/cleanspec${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}.${i_file}a
rm ${data_dir}/l${ens_name}/cleanspec${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}.${i_file}b


python3 fold_one.py <<EOF
${nt}
${ens_name}
averspec${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}
${i_file}
foldspec${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}
${data_dir}
EOF

rm ${data_dir}/l${ens_name}/averspec${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}.${i_file}


done #i_file

python3 format_corrfitter_one.py <<EOF
${ens_name}
${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}
${first}
${last}
${data_dir}
EOF

rm ${data_dir}/l${ens_name}/foldspec${prefix}${mom}${src_label}${ens_name}_xq${xq}_m${mass1}m${mass2}${sinks}.*

done #xq

done #m1

done #sinks

done #mom
