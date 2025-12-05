#!/bin/bash

ens_name="20320b726025x689327a"

src="eowfw"
prefix="hisqnlpi"
taste="PION_5"

xq="7870"
mass="0.01416"

mom="p000"

fitdir="/home/trimis/spec_data/l${ens_name}" # CMSE
dir=${fitdir} # CMSE

# fitdir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}" # LAPTOP
# dir=${fitdir} # LAPTOP

tdatamin=0
tdatamax=160
tstep=1
tp=320
n_states=1
m_states=0
sn="1.0"
so="1.0"
binsize=1

correlated="uncorr"
priors="no_priors"
opp="yes"

tmin=50
tmax=160

n_jack=100
jackbin=10

specdata_file="${dir}/${prefix}${mom}${src}${ens_name}_xq${xq}_m${mass}m${mass}${taste}.specdata"

echo "xq: ${xq}, mom: ${mom}, mass: ${mass}"

fit_file="${fitdir}/${prefix}${mom}${src}${ens_name}_xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.jackbin.${n_jack}"

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
${priors}
scanfit
${opp}
EOF

rm ${specdata_file_jackbin}
done # i_jack
