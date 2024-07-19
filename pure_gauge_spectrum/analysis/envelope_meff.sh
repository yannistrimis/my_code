#!/bin/bash
nt=320
ens_name="20320b726025x689327"
stream="a"
cur_dir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP
file_name="strp000cw20320b726025x689327xq7870_m0.05m0.05PION_5.specdata"
nbins=30

python3 corr_jack.py <<EOF
${cur_dir}/${file_name}
${nt}
${nbins}
EOF

python3 meff_hwancheol.py <<EOF
${cur_dir}/${file_name}
${nt}
${nbins}
EOF

rm ${cur_dir}/*jackbinval*
