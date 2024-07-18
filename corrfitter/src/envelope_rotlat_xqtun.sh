
#!/bin/bash

vol=1664
beta=704115
xg=181411
stream="z"
src="cw"
prefix="tun"
taste="PION_5"

# fitdir="/home/trimis/spec_data/l${vol}b${beta}x${xg}${stream}" # CMSE
# dir="/home/trimis/hpcc/plot_data/spec_data/l${vol}b${beta}x${xg}${stream}" # CMSE -> iCER
# dir="/home/trimis/fnal/all/spec_data/l${vol}b${beta}x${xg}${stream}" # CMSE -> FNAL

# fitdir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP
# dir="/home/yannis/Physics/LQCD/hpcc/plot_data/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP -> iCER
# dir="/home/yannis/Physics/LQCD/fnal/all/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP -> FNAL

fitdir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP
dir="/home/yannis/Physics/LQCD/spec_data/l${vol}b${beta}x${xg}${stream}" # LAPTOP


tdata=33
tp=64
n_states=1
m_states=0
sn="1.0"
so="0"
binsize=1

xq_arr=("1840" "1920" "2000")
mom="p000"
mass="0.07"

# yesno="prior"
yesno="free"

tmin_one=10
tmax_one=25


for xq in "${xq_arr[@]}"
do

echo "xq: ${xq}, mom: ${mom}, mass: ${mass}"

if [ -f ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.${yesno}.jackfit ]
then
rm ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.${yesno}.jackfit
fi

for i_bin in {1..40..1}
do

python3 rotlat_xqtun_fitter_v1.0.py <<EOF >> ${fitdir}/${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.${n_states}p${m_states}.bin${binsize}.${yesno}.jackfit
${dir}
${prefix}${mom}${src}${vol}b${beta}x${xg}xq${xq}_m${mass}m${mass}${taste}.specdata.jackbin_${i_bin}
${tmin_one}
${tmax_one}
${tdata}
${tp}
${n_states}
${m_states}
${sn}
${so}
${binsize}
scanfit
EOF

done # i_bin
done # xq
