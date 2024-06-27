#!/bin/bash

for i_file in {101..500..1}
do

echo $i_file

./lat_rotate /lustre1/ahisq/yannis_puregauge/lattices/l1664b704115x181411z/l1664b704115x181411z.${i_file} /lustre1/ahisq/yannis_puregauge/lattices/l1664b704115x181411z/l1664b704115x181411z_rot.${i_file}

done # i_file
