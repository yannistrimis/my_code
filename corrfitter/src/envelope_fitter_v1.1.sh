
#!/bin/bash

ens_name="20320b726025x689327a"

src="cw"
prefix="str"
taste="PION_5"

xq="7870"
mass="0.07"

mom="p000"

#fitdir="/home/trimis/spec_data/l${ens_name}" # CMSE
#dir=${fitdir} # CMSE

fitdir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}" # LAPTOP
dir=${fitdir} # LAPTOP

tdatamin=0
tdatamax=160
tstep=1
tp=320
n_states=2
m_states=0
sn="1.0"
so="1.0"
binsize=1

correlated="corr"
priors="no_priors"
opp="yes"

tmin_min=30
tmin_max=30
tmin_step=1

tmax_min=30
tmax_max=120
tmax_step=5

tmin_one=35
tmax_one=120

specdata_file="${dir}/${prefix}${mom}${src}${ens_name}_xq${xq}_m${mass}m${mass}${taste}.specdata"

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
echo ${tmin} ${tmax}

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
${priors}
scanfit
${opp}
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
${priors}
onefit
${opp}
EOF

fi
