#!/bin/bash

vol=1664
beta=704115
xg=181411
src="eowfw"
prefix="nlpi"
taste="PION_i"
to_print_state="n"
to_print_nr=0

fitdir="/home/yannis/Physics/LQCD/local_code"
dir="/home/yannis/Physics/LQCD/local_code"


tdata=33
tp=64
n_states=1
m_states=1
sn="1.0"
so="-1.0"
binsize=1

xq="1980"
mom="p000"
mass="0.0146"

# yesno="prior"
yesno="free"

tmin_min=0
tmin_max=33
tmin_step=1

tmax_min=0
tmax_max=33
tmax_step=1

tmin_one=0
tmax_one=33

echo "xq: ${xq}, mom: ${mom}, mass: ${mass}"

if [ $1 == "scan" ]
then

if [ -f ${fitdir}/mock_2pt_corr.mockfit ]
then
rm ${fitdir}/mock_2pt_corr.mockfit
fi

for ((tmin=${tmin_min};tmin<=${tmin_max};tmin=${tmin}+${tmin_step}));do
for ((tmax=${tmax_min};tmax<=${tmax_max};tmax=${tmax}+${tmax_step}));do

python3 fitter_v1.0.py <<EOF >> ${fitdir}/mock_2pt_corr.mockfit
${dir}
mock_2pt_corr.specdata
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
mock_2pt_corr.specdata
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
