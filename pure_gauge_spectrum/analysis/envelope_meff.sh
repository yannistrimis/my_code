#!/bin/bash
nt=64
ens_name="1664b704115x181411"
stream="a"
cur_dir="/home/yannis/Physics/LQCD/spec_data/l${ens_name}${stream}" # LAPTOP
file_name="nlpip000eowfw1664b704115x181411xq1980_m0.0146m0.0146PION_i.specdata"
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

#rm "${cur_dir}/*jackbin*"
