#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS

cluster=fnal

init_seed=1158
n_of_lat=1000
n_of_sub=4

nx=16
ny=16
nz=16
nt=128

beta_s=1.92771
beta_t=23.61450
xiq=3.9

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=5
traj_between_meas=1
microcanonical_time_step=0.035714
steps_per_trajectory=28

ensemble="16128f21b6747m014m070xig3500xiq3900a"
lat_name="l16128f21b6747m014m070xig3500xiq3900a"
out_name="out16128f21b6747m014m070xig3500xiq3900a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l16128f21b6747m014m070xig3500xiq3900a"
out_dir="/project/ahisq/yannis_dyn/outputs/l16128f21b6747m014m070xig3500xiq3900a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl16128f21b6747m014m070xig3500xiq3900a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl16128f21b6747m014m070xig3500xiq3900a"

#executable="su3_rhmd_hisq_a_dbl_gcc12openmpi4_20250508"
executable="su3_rhmc_hisq_a_dbl_gcc12openmpi4_20250508"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="xf39"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

