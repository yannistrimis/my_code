#!/bin/bash
start_time=$(date +%s.%N)

lat_name="l2040b708567x181690a"
lat_dir="/lustre1/ahisq/yannis_puregauge/lattices/l2040b708567x181690a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2040b708567x181690a"
M=1900

i_lat=101
n_lat=400

n_meas=0

i=0
while [ $i -le $n_lat ]
do

lat="${lat_dir}/${lat_name}.trunc.${i_lat}"
out_name="${out_dir}/NRQCD_M${M}_${lat_name}.${i_lat}.twostate"

if [ -f ${out_name} ]
then
rm ${out_name}
fi

bash control.sh ${lat} | tee ${out_name} >/dev/null

text="RUNNING COMPLETED"
complete_flag=$(bash is_complete.sh ${out_name} ${text})

if [ "${complete_flag}" = "1" ]
then
n_meas=$((${n_meas}+1))
i_lat=$((${i_lat}+1))
fi

i=$(($i+1))

done # i

echo "measured ${n_meas} out of ${n_lat} requested"
end_time=$(date +%s.%N)

elapsed_time=$(python3 -c "res=${end_time}-${start_time};print(res)")
echo "elapsed time = ${elapsed_time} sec"

