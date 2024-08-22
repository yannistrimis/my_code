#!/bin/bash

flowtime_arr=(0 0.5 1 1.5 2 2.5)

for flowtime in ${flowtime_arr[@]}; do

python3 top_charge.py <<EOF
/project/ahisq/yannis_puregauge/outputs/l1632b7100x180a/wflow1632b7100x180xf200a_dt0.015625
/project/ahisq/yannis_puregauge/outputs/l1632b7100x180a/l1632b7100x180a_charge_${flowtime}.data
${flowtime}
EOF

done

