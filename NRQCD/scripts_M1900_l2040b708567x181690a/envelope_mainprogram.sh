#!/bin/bash

lat_name="l2040b708567x181690a"
lat_dir="/lustre1/ahisq/yannis_puregauge/lattices/l2040b708567x181690a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2040b708567x181690a"
M=1900

i_lat=303
n_lat=500

n_meas=0

i=0
while [ $i -le $n_lat ]
do

if [ -f "${out_dir}/NRQCD_M${M}_${lat_name}.${i_lat}" ]
then
rm ${out_dir}/NRQCD_M${M}_${lat_name}.${i_lat}
fi

bash control.sh ${lat_dir}/${lat_name}.trunc.${i_lat} | tee ${out_dir}/NRQCD_M${M}_${lat_name}.${i_lat} >/dev/null

text="RUNNING COMPLETED"
complete_flag=$(bash is_complete.sh ${out_dir}/NRQCD_M${M}_${lat_name}.${i_lat} ${text})

if [ "${complete_flag}" = "1" ]
then
n_meas=$((${n_meas}+1))
i_lat=$((${i_lat}+1))
fi

i=$(($i+1))

done # i

echo "measured ${n_meas} out of ${n_lat} requested"
