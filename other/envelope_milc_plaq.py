#!/bin/bash

dir="/project/ahisq/yannis_puregauge/outputs"

name_arr=("l1616b489898x612372t3008/out1616b489898x612372t3008" \
"l1616b547723x547723t3010/out1616b547723x547723t3010" \
"l1616b600000x500000t3012/out1616b600000x500000t3012" \
"l1616b648074x462910t3014/out1616b648074x462910t3014" \
"l1616b692820x433013t3016/out1616b692820x433013t3016" \
"l1616b734847x408248t3018/out1616b734847x408248t3018" \
"l1616b774597x387298t3020/out1616b774597x387298t3020")

for name in ${name_arr[@]}; do

python3 milc_plaq.py <<EOF
${dir}/${name}
EOF


done # name
