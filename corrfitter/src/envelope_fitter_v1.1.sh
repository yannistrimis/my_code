#!/bin/bash

ens_name="1664f2b5300m024xig30xiq30"

stream="a"
src="eowfw"
prefix="naivnlpi"
taste="PION_5"

xq="30"
mom="p000"
mass="0.024"

fitdir="/home/trimis/spec_data/l${ens_name}${stream}" # CMSE
dir=${fitdir} # CMSE

# dir="/home/trimis/hpcc/plot_data/spec_data/l${ens_name}${stream}" # CMSE -> iCER
# dir="/home/trimis/fnal/all/spec_data/l${ens_name}${stream}" # CMSE -> FNAL

# fitdir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP
# dir="/home/yannis/Physics/LQCD/hpcc/plot_data/spec_data/l${ens_name}${stream}" # LAPTOP -> iCER
# dir="/home/yannis/Physics/LQCD/fnal/all/spec_data/l${ens_name}${stream}" # LAPTOP -> FNAL

# fitdir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP
# dir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP

tdatamin=0
tdatamax=32
tstep=1
tp=64
n_states=1
m_states=0
sn="1.0"
so="1.0"
binsize=1

correlated="corr"

tmin_min=0
tmin_max=21
tmin_step=1

tmax_min=21
tmax_max=21
tmax_step=1

tmin_one=16
tmax_one=32

specdata_file="${dir}/${prefix}${mom}${src}${ens_name}xq${xq}_m${mass}m${mass}${taste}.specdata"

echo "xq: ${xq}, mom: ${mom}, mass: ${mass}"

if [ $1 == "scan" ]
then

fit_file="${fitdir}/${prefix}${mom}${src}${ens_name}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.scanfit"


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
