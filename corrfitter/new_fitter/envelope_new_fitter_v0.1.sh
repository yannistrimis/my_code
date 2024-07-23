#!/bin/bash

corr_file="/home/yannis/Physics/LQCD/spec_data/l20320b726025x689327a/nlpip000eowfw20320b726025x689327xq7870_m0.01416m0.01416PION_5.specdata"
nt=320
nof_n=1
sn=1.0
an0_init=1.0
En0_init=0.3
nof_o=0
tmin=80
tmax=90

python3 new_fitter_v0.1.py <<EOF
${corr_file}
${nt}
${nof_n}
${sn}
${an0_init}
${En0_init}
${nof_o}
${tmin}
${tmax}
EOF
