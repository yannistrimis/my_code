
#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS
cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=24

beta_s=1.55588
beta_t=17.98600
xiq=3.4

dyn_mass=0.02210
rationals_file="rationals.m02210"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.045454545
steps_per_trajectory=22

ensemble="1624f2b5290m02210xig34xiq34a"
lat_name="l1624f2b5290m02210xig34xiq34a"
out_name="out1624f2b5290m02210xig34xiq34a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1624f2b5290m02210xig34xiq34a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1624f2b5290m02210xig34xiq34a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1624f2b5290m02210xig34xiq34a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1624f2b5290m02210xig34xiq34a"

executable="su3_rhmd_naive_plaq_a_dbl_gcc12openmpi4_20250430"


sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="run1"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

