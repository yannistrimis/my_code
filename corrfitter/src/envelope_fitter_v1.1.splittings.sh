#!/bin/bash

ens_name="1664b704115x181411"

stream="a"
src="eowfw"
prefix="naivnlpi"
taste="PION_s"

xq="154707"
mass="0.00725"

mom="p000"

# fitdir="/home/trimis/spec_data/l${ens_name}${stream}" # CMSE
# dir=${fitdir} # CMSE

# dir="/home/trimis/hpcc/plot_data/spec_data/l${ens_name}${stream}" # CMSE -> iCER
# dir="/home/trimis/fnal/all/spec_data/l${ens_name}${stream}" # CMSE -> FNAL

# fitdir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP
# dir="/home/yannis/Physics/LQCD/hpcc/plot_data/spec_data/l${ens_name}${stream}" # LAPTOP -> iCER
# dir="/home/yannis/Physics/LQCD/fnal/all/spec_data/l${ens_name}${stream}" # LAPTOP -> FNAL

fitdir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP
dir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP

tdatamin=0
tdatamax=32
tstep=1
tp=64
n_states=1
m_states=1
sn="1.0"
so="-1.0"
binsize=1

correlated="corr"

tmin=5
tmax=26

n_jack=22
jackbin=100

specdata_file="${dir}/${prefix}${mom}${src}${ens_name}xq${xq}_m${mass}m${mass}${taste}.specdata"

echo "xq: ${xq}, mom: ${mom}, mass: ${mass}"

fit_file="${fitdir}/${prefix}${mom}${src}${ens_name}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.jackbin"

if [ -f ${fit_file} ]
then
rm ${fit_file}
fi

for ((i_jack=0;i_jack<${n_jack};i_jack=${i_jack}+1));do

line_min=$((i_jack*jackbin))
line_max=$((line_min+jackbin))

specdata_file_jackbin="${specdata_file}.jackbin"
awk -v start="${line_min}" -v end="${line_max}" 'NR<=start || NR>end' ${specdata_file} > ${specdata_file_jackbin}

python3 fitter_v1.1.py <<EOF >> ${fit_file}
${specdata_file_jackbin}
${tmin}
${tmax}
${tdatamin}
${tdatamax}
${tstep}
${tp}
${n_states}
${m_states}
${sn}
${so}
${binsize}
${correlated}
scanfit
EOF

rm ${specdata_file_jackbin}
done # i_jack
