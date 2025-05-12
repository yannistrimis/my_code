
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=128

beta_s=1.92771
beta_t=23.61450
xiq=3.5

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.05
steps_per_trajectory=20

ensemble="16128f21b6747m014m070xig3500xiq3500a"
lat_name="l16128f21b6747m014m070xig3500xiq3500a"
out_name="out16128f21b6747m014m070xig3500xiq3500a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l16128f21b6747m014m070xig3500xiq3500a"
out_dir="/project/ahisq/yannis_dyn/outputs/l16128f21b6747m014m070xig3500xiq3500a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl16128f21b6747m014m070xig3500xiq3500a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl16128f21b6747m014m070xig3500xiq3500a"

executable="su3_rhmd_hisq_a_dbl_gcc12openmpi4_20250508"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="ahisq35"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

