#!/bin/bash

dir="/project/ahisq/yannis_puregauge/outputs"

name_arr=("l1616b575x100p/out1616b575x100p")

for name in ${name_arr[@]}; do

python3 milc_plaq.py <<EOF
${dir}/${name}
EOF


done # name
