
#!/bin/bash

flow_type_arr=("w")
obs_type_arr=("clover")

for flow_type in ${flow_type_arr[@]}; do
for obs_type in ${obs_type_arr[@]}; do

python3 tuning_wuppertal_new.py <<EOF
${flow_type}
${obs_type}
yes
EOF

done
done

