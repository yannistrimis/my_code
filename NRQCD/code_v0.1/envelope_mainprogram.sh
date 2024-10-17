#!/bin/bash

lat_name="wflowlat_nstep32_l2040b708567x181690a"
lat_dir="/lustre1/ahisq/yannis_puregauge/lattices/l2040b708567x181690a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2040b708567x181690a"
M=1900

for i_file in {281..282};
do

bash control.sh ${lat_name} ${lat_dir} ${i_file} | tee ${out_dir}/NRQCD_M${M}_${lat_name}.${i_file} >/dev/null

done # i_file

