#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=32

beta_s=5.63685
beta_t=7.13312
xiq=1.2

dyn_mass_1=0.0148
dyn_mass_2=0.0740
rationals_file="rationals.m0148m0740"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.05
steps_per_trajectory=20

ensemble="1632f21b6341xig112492m0148m0740xif120a"
lat_name="l1632f21b6341xig112492m0148m0740xif120a"
out_name="out1632f21b6341xig112492m0148m0740xif120a"


directory="/lustre2/ahisq/yannis_dyn/lattices/l1632f21b6341xig112492m0148m0740xif120a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1632f21b6341xig112492m0148m0740xif120a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1632f21b6341xig112492m0148m0740xif120a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1632f21b6341xig112492m0148m0740xif120a"

executable="su3_rhmd_hisq_a_dbl_gcc12openmpi4_20250508"
# executable="su3_rhmc_hisq_a_dbl_gcc12openmpi4_20250508"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="x12b6341"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

