
#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS

cluster=fnal

init_seed=1158
n_of_lat=100
n_of_sub=5

nx=16
ny=16
nz=16
nt=16

beta_s=5.51391
beta_t=7.29215
xiq=1.2

dyn_mass_1=0.0148
dyn_mass_2=0.0740
rationals_file="rationals.m0148m0740"

warms=0
trajecs=5
traj_between_meas=1
microcanonical_time_step=0.05
steps_per_trajectory=20

ensemble="1616f21b6341xig115m0148m0740xif120a"
lat_name="l1616f21b6341xig115m0148m0740xif120a"
out_name="out1616f21b6341xig115m0148m0740xif120a"


directory="/lustre2/ahisq/yannis_dyn/lattices/l1616f21b6341xig115m0148m0740xif120a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1616f21b6341xig115m0148m0740xif120a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1616f21b6341xig115m0148m0740xif120a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1616f21b6341xig115m0148m0740xif120a"

# executable="su3_rhmd_hisq_a_dbl_gcc12openmpi4_20250508"
executable="su3_rhmc_hisq_a_dbl_gcc12openmpi4_20250508"

sbatch_time="10:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="g115q12"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

