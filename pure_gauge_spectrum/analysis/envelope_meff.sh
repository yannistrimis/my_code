#!/bin/bash
nt=64
ens_name="1664b704115x181411"
stream="z"
cur_dir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP
file_name="tunp000cw1664b704115x181411xq1920_m0.07m0.07PION_5.specdata"
nbins=40

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
