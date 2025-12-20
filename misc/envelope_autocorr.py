mctime_min=0
mctime_max=100

for (( mctime=${mctime_min} ; mctime<${mctime_max} ; mctime++ ));
do

python3 autocorr_file.py <<EOF
/home/yannis/Physics/LQCD/spec_data/l20320b726025x689327a/hisqnlpip000eowfw20320b726025x689327a_xq7870_m0.01416m0.01416PION_5.specdata.t0
50
${mctime}
EOF

done # mctime
