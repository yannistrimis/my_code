#!/bin/bash

lat_dir="/home/trimis/lattices"
lat_name="l1632b681823x100000a"

vol=$(( 16*16*16*32 ))
trunc_size=$(( ${vol}*4*18*4 ))

for i_file in {2352..2352};
do

tail -c ${trunc_size} ${lat_dir}/${lat_name}.${i_file} > ${lat_dir}/${lat_name}.trunc.${i_file}

done # i_file
