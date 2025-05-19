
#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS
cluster=fnal

init_seed=1158
n_of_lat=500
n_of_sub=1

nx=16
ny=16
nz=16
nt=12

beta_s=1.76667
beta_t=15.90000
xiq=3.0

dyn_mass=0.024
rationals_file="rationals.m024"

warms=0
trajecs=5
traj_between_meas=1
microcanonical_time_step=0.05
steps_per_trajectory=20

ensemble="1612f2b5300m024xig30xiq30a"
lat_name="l1612f2b5300m024xig30xiq30a"
out_name="out1612f2b5300m024xig30xiq30a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1612f2b5300m024xig30xiq30a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1612f2b5300m024xig30xiq30a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1612f2b5300m024xig30xiq30a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1612f2b5300m024xig30xiq30a"

executable="su3_rhmc_naive_plaq_a_dbl_gcc12openmpi4_20250430"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="pbp"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

