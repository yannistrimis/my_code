#!/bin/bash

for i_file in {101..700..1}
do

echo $i_file

./lat_rotate /lustre2/ahisq/yannis_puregauge/lattices/l1664b704115x181411zl/l1664b704115x181411zl.${i_file} /lustre2/ahisq/yannis_puregauge/lattices/l1664b704115x181411zl/l1664b704115x181411zl_rot.${i_file}

done # i_file
