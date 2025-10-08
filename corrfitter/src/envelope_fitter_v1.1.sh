#!/bin/bash

ens_name="1632b681823x100000"

src="eowfw"
prefix="naivnlpi"
taste="PION_s"

xq="1000"
mass="0.00855"

mom="p000"

#fitdir="/home/trimis/spec_data/l${ens_name}" # CMSE
#dir=${fitdir} # CMSE

fitdir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}a" # LAPTOP
dir=${fitdir} # LAPTOP

tdatamin=0
tdatamax=16
tstep=1
tp=32
n_states=1
m_states=1
sn="1.0"
so="-1.0"
binsize=1

correlated="corr"

tmin_min=0
tmin_max=12
tmin_step=1

tmax_min=14
tmax_max=16
tmax_step=1

tmin_one=6
tmax_one=14

specdata_file="${dir}/${prefix}${mom}${src}${ens_name}xq${xq}_m${mass}m${mass}${taste}.specdata"

echo "xq: ${xq}, mom: ${mom}, mass: ${mass}"

if [ $1 == "scan" ]
then

fit_file="${fitdir}/${prefix}${mom}${src}${ens_name}_xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.scanfit"


if [ -f ${fit_file} ]
then
rm ${fit_file}
fi

for ((tmin=${tmin_min};tmin<=${tmin_max};tmin=${tmin}+${tmin_step}));do
for ((tmax=${tmax_min};tmax<=${tmax_max};tmax=${tmax}+${tmax_step}));do


python3 fitter_v1.1.py <<EOF >> ${fit_file}
${specdata_file}
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

done # tmax
done # tmin

elif [ $1 == "one"  ]
then

python3 fitter_v1.1.py <<EOF
${specdata_file}
${tmin_one}
${tmax_one}
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
onefit
EOF

fi
