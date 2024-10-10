#!/bin/bash

lat_name="l2040b708567x181690a"
lat_dir="/lustre1/ahisq/yannis_puregauge/lattices/${lat_name}"
out_dir="/project/ahisq/yannis_puregauge/outputs/${lat_name}"
M=1900

for i_file in {101..500};
do

bash control.sh ${lat_name} ${lat_dir} ${i_file} | tee ${out_dir}/NRQCD_M${M}_${lat_name}.${i_file}

done # i_file

