
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=24
nt=64

beta_s=1.76667
beta_t=15.90000
xiq=3.0

dyn_mass=0.024
rationals_file="rationals.m024"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.03571
steps_per_trajectory=28

ensemble="1664f2b5300m024xig30xiq30c"
lat_name="l1664f2b5300m024xig30xiq30c"
out_name="out1664f2b5300m024xig30xiq30c"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1664f2b5300m024xig30xiq30c"
out_dir="/project/ahisq/yannis_dyn/outputs/l1664f2b5300m024xig30xiq30c"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1664f2b5300m024xig30xiq30c"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1664f2b5300m024xig30xiq30c"

executable="su3_rhmd_naive_plaq_a_dbl_gcc12openmpi4_20250430"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="naivdyc"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

