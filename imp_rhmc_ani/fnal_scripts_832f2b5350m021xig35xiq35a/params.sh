#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=100
n_of_sub=1

nx=8
ny=8
nz=8
nt=32

beta_s=1.52857
beta_t=18.72500
xiq=3.5

dyn_mass=0.021
rationals_file="rationals.m021"

warms=0
trajecs=5
traj_between_meas=1
microcanonical_time_step=0.03846
steps_per_trajectory=26

ensemble="832f2b5350m021xig35xiq35a"
lat_name="l832f2b5350m021xig35xiq35a"
out_name="out832f2b5350m021xig35xiq35a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l832f2b5350m021xig35xiq35a"
out_dir="/project/ahisq/yannis_dyn/outputs/l832f2b5350m021xig35xiq35a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl832f2b5350m021xig35xiq35a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl832f2b5350m021xig35xiq35a"

executable="su3_rhmc_naive_plaq_a_dbl_gcc12openmpi4_20250430"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="pbpcomp"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

