#!/bin/bash

vol=16128
beta=719156
xg=348992
stream="a"
src="eowfw"
prefix="nlpi"
taste="PION_s"

# fitdir="/home/trimis/spec_data/l${vol}b${beta}x${xg}${stream}" # CMSE
# dir="/home/trimis/hpcc/plot_data/spec_data/l${vol}b${beta}x${xg}${stream}" # CMSE -> iCER
# dir="/home/trimis/fnal/all/spec_data/l${vol}b${beta}x${xg}${stream}" # CMSE -> FNAL

# fitdir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP
# dir="/home/yannis/Physics/LQCD/hpcc/plot_data/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP -> iCER
# dir="/home/yannis/Physics/LQCD/fnal/all/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP -> FNAL

fitdir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP
dir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP


tdatamin=0
tdatamax=64
tstep=3
tp=128
n_states=1
m_states=1
sn="1.0"
so="-1.0"
binsize=1

xq="4000"
mom="p000"
mass="0.01446"

correlated="corr"
#correlated="uncorr"

tmin_min=23
tmin_max=23
tmin_step=1

tmax_min=30
tmax_max=50
tmax_step=1

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
${dir}
${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.specdata.temp
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
${dir}
${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.specdata.temp
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
