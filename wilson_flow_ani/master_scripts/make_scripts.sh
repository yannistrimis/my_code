#!/bin/bash

# THIS SCRIPT CREATES DIRECTORIES FOR PURE GAUGE GRADIENT FLOW.
# IF MULTIPLE DIRECTORIES ARE NEEDED, THE USER CAN CREATE ARRAYS
# FOR THE CHANGING PARAMETERS.

cluster="fnal"
n_of_ens=1

nx=16
nt=32

beta_name_arr=("684652")
xi_0_name_arr=("107865")
stream="a"

xi_f=1.10
xi_f_name="110"

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime_arr=("3.5") # CAREFUL!!!

sbatch_time="20:00:00"
sbatch_nodes=2 # N/A WHEN icer IS SELECTED
sbatch_ntasks=64
sbatch_jobname_arr=("x11tun")

n_of_sub=1
n_of_lat=300
first_lattice=101

for (( i_ens=0; i_ens<${n_of_ens}; i_ens++ )); do

# SUBSTITUTE ARRAY ELEMENTS HERE, IF ANY

beta_name=${beta_name_arr[${i_ens}]}
xi_0_name=${xi_0_name_arr[${i_ens}]}
stoptime=${stoptime_arr[${i_ens}]}
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

out_name="${prefix}${ensemble_nostream}xf${xi_f_name}${stream}_dt${dt}"
my_dir="${cluster}_${prefix}_scripts_${ensemble}"

cd ..
mkdir ${my_dir}
cd master_scripts

# ==================================================================================
# ==================================================================================
cat <<EOF > ../${my_dir}/params.sh

#!/bin/bash

cluster=${cluster}

first_lattice=${first_lattice}

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
run_dir="/mnt/scratch/trimisio/runs/run${prefix}${lat_name}"
submit_dir="/mnt/home/trimisio/submits/sub${prefix}${lat_name}"

executable="region_flow_bbb_a_dbl_gompi2020b_20240213"

sbatch_time="${sbatch_time}"
sbatch_ntasks="${sbatch_ntasks}"
sbatch_jobname="${sbatch_jobname}"
sbatch_module="gompi/2020b"

EOF

elif [ ${cluster} == "fnal" ]
then

cat <<EOF >> ../${my_dir}/params.sh

directory="/lustre1/ahisq/yannis_puregauge/lattices/${lat_name}"
out_dir="/project/ahisq/yannis_puregauge/outputs/${lat_name}"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/run${prefix}${lat_name}"
submit_dir="/project/ahisq/yannis_puregauge/submits/sub${prefix}${lat_name}"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

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


done # i_ens
