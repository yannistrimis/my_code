#!/bin/bash

# THIS SCRIPT CREATES DIRECTORIES FOR IMPROVED RHMC ENSEMBLE GENERATION.
# IF MULTIPLE DIRECTORIES ARE NEEDED, THE USER CAN CREATE ARRAYS
# FOR THE CHANGING PARAMETERS.

cluster="fnal"
n_of_ens=6

nx=16
nt=16

beta=6.8
beta_name="6800"

xig=1.10
xig_name="1100"

xiq=1.10
xiq_name="1100"

dyn_mass_1=0.004
dyn_mass_1_name="0040"

dyn_mass_2=0.02
dyn_mass_2_name="0200"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step_arr=(0.05 0.04 0.02 0.01 0.005 0.0025)
steps_per_trajectory_arr=(20 25 50 100 200 400)

stream_arr=("a" "b" "c" "d" "e" "f")

sbatch_time="22:00:00"
sbatch_nodes=2
sbatch_ntasks=64
sbatch_jobname_arr=("rhmc_a" "rhmc_b" "rhmc_c" "rhmc_d" "rhmc_e" "rhmc_f")

n_of_sub=1
n_of_lat=1


for (( i_ens=0; i_ens<${n_of_ens}; i_ens++ )); do

# SUBSTITUTE ARRAY ELEMENTS HERE, IF ANY

microcanonical_time_step=${microcanonical_time_step_arr[${i_ens}]}
steps_per_trajectory=${steps_per_trajectory_arr[${i_ens}]}
stream=${stream_arr[${i_ens}]}
sbatch_jobname=${sbatch_jobname_arr[${i_ens}]}

#

beta_s=$(python3 -c "b_s=${beta}/${xig};print('%.5lf'%b_s)")
beta_t=$(python3 -c "b_t=${beta}*${xig};print('%.5lf'%b_t)")

ensemble="${nx}${nt}f21b${beta_name}m${dyn_mass_1_name}m${dyn_mass_2_name}xig${xig_name}xiq${xiq_name}${stream}"
lat_name="l${ensemble}"
out_name="out${ensemble}"

my_dir="${cluster}_scripts_${ensemble}"

cd ..
mkdir ${my_dir}
cd master_scripts_f21

# ==================================================================================
# ==================================================================================
cat <<EOF > ../${my_dir}/params.sh

#!/bin/bash

cluster=${cluster}

init_seed=1158
n_of_lat=${n_of_lat}
n_of_sub=${n_of_sub}

nx=${nx}
ny=${nx}
nz=${nx}
nt=${nt}

beta_s=${beta_s}
beta_t=${beta_t}
xiq=${xiq}

dyn_mass_1=${dyn_mass_1}
dyn_mass_2=${dyn_mass_2}

warms=${warms}
trajecs=${trajecs}
traj_between_meas=${traj_between_meas}
microcanonical_time_step=${microcanonical_time_step}
steps_per_trajectory=${steps_per_trajectory}

ensemble="${ensemble}"
lat_name="${lat_name}"
out_name="${out_name}"

EOF

if [ ${cluster} == "icer" ]
then

echo "no icer case for imp rhmc"

elif [ ${cluster} == "fnal" ]
then

cat <<EOF >> ../${my_dir}/params.sh

directory="/lustre1/ahisq/yannis_dyn/lattices/${lat_name}"
out_dir="/project/ahisq/yannis_dyn/outputs/${lat_name}"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungen${lat_name}"
submit_dir="/project/ahisq/yannis_dyn/submits/subgen${lat_name}"

executable="su3_rhmc_hisq_a_dbl_gcc12openmpi4_20250127"

sbatch_time="${sbatch_time}"
sbatch_nodes="${sbatch_nodes}"
sbatch_ntasks="${sbatch_ntasks}"
sbatch_jobname="${sbatch_jobname}"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

EOF

fi

# =====================================================================================
# =====================================================================================


cp control_script.sh ../${my_dir}/control_script.sh
cp is_complete.sh ../${my_dir}/is_complete.sh
cp make_input.sh ../${my_dir}/make_input.sh
cp make_submit.sh ../${my_dir}/make_submit.sh
cp envelope_script.sh ../${my_dir}/envelope_script.sh
cp rationals.sample.su3_rhmc_hisq ../${my_dir}/rationals.sample.su3_rhmc_hisq

done # i_ens
