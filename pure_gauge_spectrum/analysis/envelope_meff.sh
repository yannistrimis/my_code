#!/bin/bash
nt=128
ens_name="16128b719156x348992"
stream="a"
cur_dir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP
file_name="nlpip000eowfw16128b719156x348992xq4000_m0.01446m0.01446PION_0.specdata"
nbins=50

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

rm ${cur_dir}/*jackbin*
