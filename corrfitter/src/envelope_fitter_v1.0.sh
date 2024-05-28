#!/bin/bash

vol=1664
beta=704115
xg=181411
src="cw"
prefix="tun"
taste="PION_5"
to_print_state="n"
to_print_nr=0

fitdir="/home/trimis/spec_data/l${vol}b${beta}x${xg}a" # CMSE
dir="/home/trimis/hpcc/plot_data/spec_data/l${vol}b${beta}x${xg}a" # CMSE

tdata=33
tp=64
n_states=1
m_states=1
so="-1.0"
binsize=1

#yesno="prior"
yesno="free"

if [ $1 == "scan" ]
then

tmin_min=4
tmin_max=20
tmin_step=1

tmax_min=27
tmax_max=27
tmax_step=1

xq_arr=( "1880" )
mom_arr=( "p110" )
mass_arr=( "0.06" )

for xq in ${xq_arr[@]};do
echo "xq = ${xq}"
for mom in ${mom_arr[@]};do
echo "	mom: ${mom}"
for mass in ${mass_arr[@]};do
echo "		mass: ${mass}"

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

xq="2000"
mom="p110"
tmin=11
tmax=27

mass=0.06

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
