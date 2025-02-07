#!/bin/bash

# THIS SCRIPT CREATES DIRECTORIES FOR aHISQ SPECTRUM.
# IF MULTIPLE DIRECTORIES ARE NEEDED, THE USER CAN CREATE ARRAYS
# FOR THE CHANGING PARAMETERS.

cluster="fnal"
n_of_ens=1

nx=16
ny=16
nz=16
nt=32

set_i_lat=101
set_seed=78324

beta_name="681823"
xi_0_name="100000"
stream="a"

u0=1

set_source_start=0
n_sources=2
source_inc=16 # CHANGE ACCORDING TO nt
source_prec=10 # CHANGE ACCORDING TO nt

nmasses=1
mass1=0.01524

nxq=1
xq1=1.000

xq1_name="1000"

action="hisq"
err=1e-6
max_cg_iterations=300
precision=2

sbatch_time="20:00:00"
sbatch_nodes=2 # N/A WHEN icer IS SELECTED
sbatch_ntasks=64
sbatch_jobname="hisq1pg"

prefix="hisqnlpi"
build_prefix="nlpi"

n_of_sub=10
n_of_lat=1000

for (( i_ens=0; i_ens<${n_of_ens}; i_ens++ )); do

# SUBSTITUTE ARRAY ELEMENTS HERE, IF ANY

ensemble_nostream="${nx}${nt}b${beta_name}x${xi_0_name}"
ensemble="${ensemble_nostream}${stream}"
lat_name="l${ensemble}"

out_name="spec${prefix}${ensemble_nostream}"
my_dir="${cluster}_${prefix}_scripts_${ensemble}"

build_script="build_input_${build_prefix}_new.sh"

cd ..
mkdir ${my_dir}
cd master_scripts

# ==================================================================================
# ==================================================================================
cat <<EOF > ../${my_dir}/params.sh

#!/bin/bash

cluster=${cluster}

n_of_lat=${n_of_lat}
n_of_sub=${n_of_sub}

set_i_lat=${set_i_lat}
set_seed=${set_seed}

nx=${nx}
ny=${ny}
nz=${nz}
nt=${nt}

lat_name="${lat_name}"
out_name="${out_name}"

nmasses=${nmasses}
mass_arr=( ${mass1} ${mass2} ${mass3} ${mass4} ${mass5} ${mass6} )

nxq=${nxq}
xq_arr=( ${xq1} ${xq2} ${xq3} ${xq4} ${xq5} ${xq6} )
xq_name_arr=( ${xq1_name} ${xq2_name} ${xq3_name} ${xq4_name} ${xq5_name} ${xq6_name} )

u0=${u0}

set_source_start=${set_source_start}
n_sources=${n_sources}
source_inc=${source_inc}
source_prec=${source_prec}

action=${action}
err=${err}
max_cg_iterations=${max_cg_iterations}
precision=${precision}

build_script=${build_script}

EOF

if [ ${cluster} == "icer" ]
then

cat <<EOF >> ../${my_dir}/params.sh

directory="/mnt/scratch/trimisio/lattices/${lat_name}"
out_dir="/mnt/home/trimisio/outputs/pure_gauge_spec/${lat_name}"
path_build="/mnt/home/trimisio/my_code/pure_gauge_spectrum/build"
run_dir="/mnt/scratch/trimisio/runs/runspec${prefix}${lat_name}"
submit_dir="/mnt/home/trimisio/submits/subspec${prefix}${lat_name}"

executable="ks_spectrum_ani_hisq_icc_dbl_20230619"

sbatch_time="${sbatch_time}"
sbatch_ntasks="${sbatch_ntasks}"
sbatch_jobname="${sbatch_jobname}"
sbatch_module="intel/2020b"

EOF

elif [ ${cluster} == "fnal" ]
then

cat <<EOF >> ../${my_dir}/params.sh

directory="/lustre1/ahisq/yannis_puregauge/lattices/${lat_name}"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/${lat_name}"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspec${prefix}${lat_name}"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspec${prefix}${lat_name}"

# executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20241118"
executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20241022"

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
cp ${build_script} ../${my_dir}/${build_script}

done # i_ens
