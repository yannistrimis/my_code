#!/bin/bash

# THIS SCRIPT CREATES DIRECTORIES FOR PURE GAUGE ENSEMBLE GENERATION.
# IF MULTIPLE DIRECTORIES ARE NEEDED, THE USER CAN CREATE ARRAYS
# FOR THE CHANGING PARAMETERS.

cluster="nersc"
n_of_ens=1

nx=16
nt=32

beta_arr=(6.71789)
beta_name_arr=("671789")

xi_0_arr=(1.00000)
xi_0_name_arr=("100000")

stream="a"

sbatch_time="04:00:00"
sbatch_nodes=2
sbatch_ntasks_per_node=32 # Only relevant for iCER.
sbatch_ntasks=64
sbatch_jobname_arr=("g020x1")

n_of_sub=1
n_of_lat=4


for (( i_ens=0; i_ens<${n_of_ens}; i_ens++ )); do

# SUBSTITUTE ARRAY ELEMENTS HERE, IF ANY

beta=${beta_arr[${i_ens}]}
beta_name=${beta_name_arr[${i_ens}]}

xi_0=${xi_0_arr[${i_ens}]}
xi_0_name=${xi_0_name_arr[${i_ens}]}

sbatch_jobname=${sbatch_jobname_arr[${i_ens}]}

#

beta_s=$(python3 -c "b_s=${beta}/${xi_0};print('%.5lf'%b_s)")
beta_t=$(python3 -c "b_t=${beta}*${xi_0};print('%.5lf'%b_t)")

ensemble="${nx}${nt}b${beta_name}x${xi_0_name}${stream}"
lat_name="l${ensemble}"
out_name="out${ensemble}"

my_dir="${cluster}_scripts_${ensemble}"

cd ..
mkdir ${my_dir}
cd master_scripts

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

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=${beta_s} #in the MILC colde this appears first
beta_t=${beta_t} #and this appears second

beta_name="${beta_name}"
xi_0_name="${xi_0_name}"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="${stream}"

ensemble="${ensemble}"
lat_name="${lat_name}"
out_name="${out_name}"

EOF

if [ ${cluster} == "icer" ]
then

cat <<EOF >> ../${my_dir}/params.sh

directory="/mnt/scratch/trimisio/lattices/${lat_name}"
out_dir="/mnt/home/trimisio/outputs/${lat_name}"
path_build="/mnt/home/trimisio/my_code/pure_gauge_ani_generation/build"
run_dir="/mnt/scratch/trimisio/runs/rungen${lat_name}"
submit_dir="/mnt/home/trimisio/submits/subgen${lat_name}"

executable="su3_ora_symzk0_a_dbl_GCC12OpenMPI4_20250321"

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
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungen${lat_name}"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgen${lat_name}"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

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
path_build="/global/homes/t/trimisio/my_code/pure_gauge_ani_generation/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/rungen${lat_name}"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/subgen${lat_name}"

executable="su3_ora_symzk0_a"

sbatch_time="${sbatch_time}"
sbatch_nodes="${sbatch_nodes}"
sbatch_ntasks_per_node="${sbatch_ntasks_per_node}"
sbatch_ntasks="${sbatch_ntasks}"
sbatch_jobname="${sbatch_jobname}"

EOF

fi

# =====================================================================================
# =====================================================================================


cp control_script.sh ../${my_dir}/control_script.sh
cp is_complete.sh ../${my_dir}/is_complete.sh
cp make_input.sh ../${my_dir}/make_input.sh
cp make_submit.sh ../${my_dir}/make_submit.sh
cp envelope_script.sh ../${my_dir}/envelope_script.sh


done # i_ens
