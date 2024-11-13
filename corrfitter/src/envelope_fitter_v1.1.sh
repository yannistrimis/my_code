#!/bin/bash

vol=1296
beta=575
xg=3136
stream="p"
src="eowfw"
prefix="nlpi"
taste="PION_ij"

xq="283"
mom="p000"
mass="0.1"

fitdir="/home/trimis/spec_data/l${vol}b${beta}x${xg}${stream}" # CMSE
dir=${fitdir}
# dir="/home/trimis/hpcc/plot_data/spec_data/l${vol}b${beta}x${xg}${stream}" # CMSE -> iCER
# dir="/home/trimis/fnal/all/spec_data/l${vol}b${beta}x${xg}${stream}" # CMSE -> FNAL

# fitdir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP
# dir="/home/yannis/Physics/LQCD/hpcc/plot_data/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP -> iCER
# dir="/home/yannis/Physics/LQCD/fnal/all/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP -> FNAL

# fitdir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP
# dir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP


tdatamin=0
tdatamax=48
tstep=1
tp=96
n_states=2
m_states=1
sn="-1.0"
so="1.0"
binsize=1

correlated="corr" # "uncorr"

tmin_min=10
tmin_max=48
tmin_step=2

tmax_min=38
tmax_max=48
tmax_step=2

tmin_one=6
tmax_one=48

echo "xq: ${xq}, mom: ${mom}, mass: ${mass}"

if [ $1 == "scan" ]
then

if [ -f ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.scanfit ]
then
rm ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.scanfit
fi

for ((tmin=${tmin_min};tmin<=${tmin_max};tmin=${tmin}+${tmin_step}));do
for ((tmax=${tmax_min};tmax<=${tmax_max};tmax=${tmax}+${tmax_step}));do


python3 fitter_v1.1.py <<EOF >> ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.scanfit
${dir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.specdata
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
${dir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.specdata
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
