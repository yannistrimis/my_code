#!/bin/bash

vol=1664
beta=704115
xg=181411
src="eowfw"
prefix="nlpi"
taste="PION_i"
to_print_state="n"
to_print_nr=0

# fitdir="/home/trimis/spec_data/l${vol}b${beta}x${xg}a" # CMSE
# dir="/home/trimis/hpcc/plot_data/spec_data/l${vol}b${beta}x${xg}a" # CMSE -> iCER
# dir="/home/trimis/fnal/all/spec_data/l${vol}b${beta}x${xg}a" # CMSE -> FNAL

fitdir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}a" # LAPTOP
dir="/home/yannis/Physics/LQCD/hpcc/plot_data/spec_data/l${vol}b${beta}x${xg}a" # LAPTOP -> iCER
# dir="/home/yannis/Physics/LQCD/fnal/all/spec_data/l${vol}b${beta}x${xg}a" # LAPTOP -> FNAL


tdata=33
tp=64
n_states=2
m_states=2
sn="1.0"
so="1.0"
binsize=1

xq="1980"
mom="p000"
mass="0.0146"

# yesno="prior"
yesno="free"

tmin_min=0
tmin_max=4
tmin_step=1

tmax_min=10
tmax_max=14
tmax_step=1

tmin_one=0
tmax_one=33

echo "xq: ${xq}, mom: ${mom}, mass: ${mass}"

if [ $1 == "scan" ]
then

if [ -f ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.E${to_print_state}${to_print_nr}.${yesno}.scanfit ]
then
rm ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.E${to_print_state}${to_print_nr}.${yesno}.scanfit
fi

for ((tmin=${tmin_min};tmin<=${tmin_max};tmin=${tmin}+${tmin_step}));do
for ((tmax=${tmax_min};tmax<=${tmax_max};tmax=${tmax}+${tmax_step}));do

python3 fitter_v1.0.py <<EOF >> ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.E${to_print_state}${to_print_nr}.${yesno}.scanfit
${dir}
${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.specdata
${tmin}
${tmax}
${tdata}
${tp}
${n_states}
${m_states}
${sn}
${so}
${binsize}
scanfit
${to_print_state}
${to_print_nr}
EOF

done # tmin
done # tmax

elif [ $1 == "one"  ]
then

python3 fitter_v1.0.py <<EOF
${dir}
${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.specdata
${tmin_one}
${tmax_one}
${tdata}
${tp}
${n_states}
${m_states}
${sn}
${so}
${binsize}
onefit
NA
NA
EOF

fi
