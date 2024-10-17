#!/bin/bash

lat_dir="/lustre1/ahisq/yannis_puregauge/lattices/l2040b708567x181690a"
lat_name="wflowlat_nstep32_l2040b708567x181690a"

vol=$(( 20*20*20*40 ))
trunc_size=$(( ${vol}*4*18*4 ))

for i_file in {101..500};
do

tail -c ${trunc_size} ${lat_dir}/${lat_name}.${i_file} > ${lat_dir}/${lat_name}.trunc.${i_file}

done # i_file
