#!/bin/bash

vol=1664
beta=70805
xg=18876
src="eowfw"
prefix="nlpi"
taste="PION_ij"
to_print_state="Eo"
to_print_nr=0

#fitdir="/home/trimis/spec_data" # CMSE
#dir="/home/trimis/fnal/all/spec_data/l${vol}b${beta}x${xg}a" # CMSE
fitdir="/home/yannis/Physics/LQCD/spec_data" # LAPTOP
dir="/home/yannis/Physics/LQCD/fnal/all/spec_data/l${vol}b${beta}x${xg}a" # LAPTOP
tdata=33
tp=64
n_states=1
m_states=1
so="1.0"
binsize=1

#yesno="prior"
yesno="free"

if [ $1 == "scan" ]
then

tmin_min=9
tmin_max=12

tmax_min=17
tmax_max=17

xq_arr=( "1950" )
mom_arr=( "p000" )
mass_arr=( "0.01532" )

for xq in ${xq_arr[@]};do
echo "xq = ${xq}"
for mom in ${mom_arr[@]};do
echo "	mom: ${mom}"
for mass in ${mass_arr[@]};do
echo "		mass: ${mass}"

if [ -f ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.${to_print_state}${to_print_nr}.${yesno}.scanfit ]
then
rm ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.${to_print_state}${to_print_nr}.${yesno}.scanfit
fi

for ((tmin=${tmin_min};tmin<=${tmin_max};tmin++));do
for ((tmax=${tmax_min};tmax<=${tmax_max};tmax++));do

python3 fitter_v1.0.py <<EOF >> ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.${to_print_state}${to_print_nr}.${yesno}.scanfit
${dir}
${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.specdata
${tmin}
${tmax}
${tdata}
${tp}
${n_states}
${m_states}
${so}
${binsize}
scanfit
${to_print_state}
${to_print_nr}
EOF

done # tmin
done # tmax

done # mass
done # mom
done # xq

elif [ $1 == "one"  ]
then

xq="1950"
mom="p000"
tmin=9
tmax=17

mass=0.01532

python3 fitter_v1.0.py <<EOF
${dir}
${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.specdata
${tmin}
${tmax}
${tdata}
${tp}
${n_states}
${m_states}
${so}
${binsize}
onefit
NA
NA
EOF


fi
