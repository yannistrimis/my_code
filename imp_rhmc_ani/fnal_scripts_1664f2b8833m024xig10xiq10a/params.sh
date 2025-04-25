#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=200
n_of_sub=1

nx=16
ny=16
nz=16
nt=64

beta_s=8.83300
beta_t=8.83300
xiq=1.0

dyn_mass=0.024
rationals_file="rationals.m024"

warms=0
trajecs=5
traj_between_meas=1
microcanonical_time_step=0.05
steps_per_trajectory=20

ensemble="1664f2b8833m024xig10xiq10a"
lat_name="l1664f2b8833m024xig10xiq10a"
out_name="out1664f2b8833m024xig10xiq10a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1664f2b8833m024xig10xiq10a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1664f2b8833m024xig10xiq10a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1664f2b8833m024xig10xiq10a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1664f2b8833m024xig10xiq10a"

# executable="su3_rhmd_naive_a_dbl_gcc12openmpi4_20250410"
executable="su3_rhmc_naive_a_dbl_gcc12openmpi4_20250421"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="naivdyn1"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

