#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS

cluster=fnal

init_seed=1158
n_of_lat=1000
n_of_sub=5

nx=16
ny=16
nz=16
nt=32

beta_s=6.74700
beta_t=6.74700
xiq=1.0

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=5
traj_between_meas=1
microcanonical_time_step=0.05
steps_per_trajectory=20

ensemble="1632f21b6747m014m070xig1000xiq1000a"
lat_name="l1632f21b6747m014m070xig1000xiq1000a"
out_name="out1632f21b6747m014m070xig1000xiq1000a"


directory="/lustre2/ahisq/yannis_dyn/lattices/l1632f21b6747m014m070xig1000xiq1000a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1632f21b6747m014m070xig1000xiq1000a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1632f21b6747m014m070xig1000xiq1000a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1632f21b6747m014m070xig1000xiq1000a"

#executable="su3_rhmd_hisq_a_dbl_gcc12openmpi4_20250508"
executable="su3_rhmc_hisq_a_dbl_gcc12openmpi4_20250508"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="1010m07"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

