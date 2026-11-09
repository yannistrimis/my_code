#!/bin/bash

Nn=1
No=2

tmin_min=0
tmin_max=31

tmax_min=31
tmax_max=31


filename="/home/yannis/Physics/LQCD/spec_data/l1664b704115x181411a/hisqnlpip000eowfw1664b704115x181411a_xq1980_m0.0146m0.0146PION_05"

if [ -f "${filename}.${Nn}p${No}.scanfit" ]; then
    rm "${filename}.${Nn}p${No}.scanfit"
fi

for tmin in $(seq "$tmin_min" "$tmin_max"); do
    for tmax in $(seq "$tmax_min" "$tmax_max"); do

        cat > input.txt << EOF
${Nn}
${No}
64
-1
1 -1
1
1
0.2973
0.373183
0.1741 0.013865
0.128981 0.853897
$tmin
$tmax
correlated
${filename}.specdata
partial_output
EOF

        python3 fitter_20261016.py < input.txt >> ${filename}.${Nn}p${No}.scanfit
    done
done
