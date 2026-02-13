#!/bin/bash

# THIS SCRIPT CREATES DIRECTORIES FOR PURE GAUGE GRADIENT FLOW.
# IF MULTIPLE DIRECTORIES ARE NEEDED, THE USER CAN CREATE ARRAYS
# FOR THE CHANGING PARAMETERS.

cluster="nersc"
n_of_ens=5

nx=20
nt=160

beta_name="7433"
xi_0_name_arr=("68500" "68570" "69000" "70000" "71000")
stream="a"

xi_f=8.0
xi_f_name="800"

flow_action="zeuthen"
exp_order="16"
dt="0.0078125"
stoptime="5.0" # CAREFUL!!!

sbatch_time="20:00:00"
sbatch_nodes=2 # MAY OR MAY NOT BE RELEVANT
sbatch_ntasks_per_node=NA # MAY OR MAY NOT BE RELEVANT
sbatch_ntasks=256 # IN HYPER_SL32 EACH SUBLAT SHOULD HAVE MULTIPLE OF 32 POINTS
sbatch_jobname_arr=("zf68500" "zf68570" "zf69000" "zf70000" "zf71000")

n_of_sub=4
n_of_lat=500
first_lattice=101
traj_step=1

for (( i_ens=0; i_ens<${n_of_ens}; i_ens++ )); do

# SUBSTITUTE ARRAY ELEMENTS HERE, IF ANY

xi_0_name=${xi_0_name_arr[${i_ens}]}

sbatch_jobname=${sbatch_jobname_arr[${i_ens}]}

# SUBSTITUTE ARRAY ELEMENTS HERE, IF ANY

ensemble="${nx}${nt}b${beta_name}x${xi_0_name}${stream}"
lat_name="l${ensemble}"

ensemble_nostream="${nx}${nt}b${beta_name}x${xi_0_name}"

if [ ${flow_action} == "wilson"  ]
then
prefix="wflow"
elif [ ${flow_action} == "symanzik" ]
then
prefix="sflow"
elif [ ${flow_action} == "zeuthen" ]
then
prefix="zflow"
fi

out_name="${prefix}${ensemble}_xf${xi_f_name}_dt${dt}"
my_dir="${cluster}_${prefix}_scripts_${ensemble}_xf${xi_f_name}_dt${dt}"

cd ..
mkdir ${my_dir}
cd master_scripts

# ==================================================================================
# ==================================================================================
cat <<EOF > ../${my_dir}/params.sh

#!/bin/bash

cluster=${cluster}

first_lattice=${first_lattice}
traj_step=${traj_step}

n_of_lat=${n_of_lat}
n_of_sub=${n_of_sub}

nx=${nx}
ny=${nx}
nz=${nx}
nt=${nt}

lat_name="${lat_name}"
out_name="${out_name}"

xi_f=${xi_f}

flow_action="${flow_action}"
exp_order="${exp_order}"
dt="${dt}"
stoptime="${stoptime}"

EOF

if [ ${cluster} == "icer" ]
then

cat <<EOF >> ../${my_dir}/params.sh

directory="/mnt/scratch/trimisio/lattices/${lat_name}"
out_dir="/mnt/home/trimisio/outputs/${lat_name}"
path_build="/mnt/home/trimisio/my_code/wilson_flow_ani/build"
run_dir="/mnt/scratch/trimisio/runs/run${prefix}${lat_name}_xf${xi_f_name}_dt${dt}"
submit_dir="/mnt/home/trimisio/submits/sub${prefix}${lat_name}_xf${xi_f_name}_dt${dt}"

executable="region_flow_bbb_a_dbl_GCC12OpenMPI4_20250924"

sbatch_time="${sbatch_time}"
sbatch_nodes="${sbatch_nodes}"
sbatch_ntasks_per_node="${sbatch_ntasks_per_node}"
sbatch_ntasks="${sbatch_ntasks}"
sbatch_jobname="${sbatch_jobname}"
sbatch_module1="GCC/12"
sbatch_module2="OpenMPI/4"

EOF

elif [ ${cluster} == "fnal" ]
then

cat <<EOF >> ../${my_dir}/params.sh

directory="/lustre1/ahisq/yannis_puregauge/lattices/${lat_name}"
out_dir="/project/ahisq/yannis_puregauge/outputs/${lat_name}"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/run${prefix}${lat_name}_xf${xi_f_name}_dt${dt}"
submit_dir="/project/ahisq/yannis_puregauge/submits/sub${prefix}${lat_name}_xf${xi_f_name}_dt${dt}"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="${sbatch_time}"
sbatch_nodes="${sbatch_nodes}"
sbatch_ntasks="${sbatch_ntasks}"
sbatch_jobname="${sbatch_jobname}"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

EOF

elif [ ${cluster} == "nersc" ]
then

cat <<EOF >> ../${my_dir}/params.sh

directory="/global/cfs/projectdirs/m1416/yannis_puregauge/lattices/${lat_name}"
out_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/outputs/${lat_name}"
path_build="/global/homes/t/trimisio/my_code/wilson_flow_ani/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/run${prefix}${lat_name}_xf${xi_f_name}_dt${dt}"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/sub${prefix}${lat_name}_xf${xi_f_name}_dt${dt}"

executable="region_flow_bbb_a_dbl_crayintel_20251110"

sbatch_time="${sbatch_time}"
sbatch_nodes="${sbatch_nodes}"
sbatch_ntasks="${sbatch_ntasks}"
sbatch_jobname="${sbatch_jobname}"

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
