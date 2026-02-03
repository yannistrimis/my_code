#!/bin/bash

# THIS SCRIPT CREATES DIRECTORIES FOR IMPROVED RHMC ENSEMBLE GENERATION.
# IF MULTIPLE DIRECTORIES ARE NEEDED, THE USER CAN CREATE ARRAYS
# FOR THE CHANGING PARAMETERS.

cluster="fnal"
n_of_ens=1

nx=16
nt=12

beta=5.29
beta_name="5290"

xig=3.4
xig_name="34"

xiq=3.4
xiq_name="34"

dyn_mass=0.02210
dyn_mass_name="02210"


warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step_arr=(0.045454545)
steps_per_trajectory_arr=(22)
rationals_file="rationals.m02210"

stream_arr=("a")

sbatch_time="20:00:00"
sbatch_nodes=4
sbatch_ntasks=128
sbatch_jobname_arr=("run4")

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

ensemble="${nx}${nt}f2b${beta_name}xig${xig_name}m${dyn_mass_name}xiq${xiq_name}${stream}"
lat_name="l${ensemble}"
out_name="out${ensemble}"

my_dir="${cluster}_scripts_${ensemble}"

cd ..
mkdir ${my_dir}
cd master_scripts_f2

# ==================================================================================
# ==================================================================================
cat <<EOF > ../${my_dir}/params.sh

#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS
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

dyn_mass=${dyn_mass}
rationals_file="${rationals_file}"

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

# executable="su3_rhmd_hisq_a_dbl_gcc12openmpi4_20250508"
# executable="su3_rhmc_hisq_a_dbl_gcc12openmpi4_20250508"


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
cp ../../make_submit.sh ../${my_dir}/make_submit.sh
cp envelope_script.sh ../${my_dir}/envelope_script.sh

done # i_ens
