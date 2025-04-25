#!/bin/bash

source ${3}/params.sh

i_curr=$1
seed=$2

cat << EOF > ${submit_dir}/input

prompt 0
nx $nx
ny $ny
nz $nz
nt $nt
iseed ${seed}

n_pseudo 4
load_rhmc_params ${3}/${rationals_file}
beta ${beta_s} ${beta_t}
n_dyn_masses 2
dyn_mass ${dyn_mass_1} ${dyn_mass_2}
dyn_flavors 2 1
u0 1.0
ani_dir t
ani_xiq ${xiq}

warms ${warms}
trajecs ${trajecs}
traj_between_meas ${traj_between_meas}
microcanonical_time_step ${microcanonical_time_step}
steps_per_trajectory ${steps_per_trajectory}
cgresid_md_fa_gr .0005 .0001 .0001
max_multicg_md_fa_gr  2500  2500  2500
cgprec_md_fa_gr  2 2 2
cgresid_md_fa_gr .000005 1e-6 1e-6
max_multicg_md_fa_gr  2500  2500  2500
cgprec_md_fa_gr  2 2 2
cgresid_md_fa_gr .000005 1e-6 1e-6
max_multicg_md_fa_gr  2500  2500  2500
cgprec_md_fa_gr  2 2 2
cgresid_md_fa_gr .000005 1e-6 1e-6
max_multicg_md_fa_gr  2500  2500  2500
cgprec_md_fa_gr  2 2 2
prec_ff 2
number_of_pbp_masses 2
max_cg_prop 500
max_cg_prop_restarts 5
npbp_reps 1
prec_pbp 1
mass ${dyn_mass_1}
error_for_propagator 1e-6
rel_error_for_propagator 0
mass ${dyn_mass_2}
error_for_propagator 1e-6
rel_error_for_propagator 0
EOF

if [ $i_curr -gt 1 ]
then
i_prev=$((${i_curr}-1))

cat << EOF >> ${submit_dir}/input
reload_serial ${directory}/${lat_name}.${i_prev}
EOF

elif [ $i_curr -eq 1 ]
then

cat << EOF >> ${submit_dir}/input
fresh
EOF

fi

cat << EOF >> ${submit_dir}/input
save_serial ${directory}/${lat_name}.${i_curr}
EOF
