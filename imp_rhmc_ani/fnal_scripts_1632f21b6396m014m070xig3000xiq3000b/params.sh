
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=32

beta_s=2.13200
beta_t=19.18800
xiq=3.0

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.03846
steps_per_trajectory=26

ensemble="1632f21b6396m014m070xig3000xiq3000b"
lat_name="l1632f21b6396m014m070xig3000xiq3000b"
out_name="out1632f21b6396m014m070xig3000xiq3000b"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1632f21b6396m014m070xig3000xiq3000b"
out_dir="/project/ahisq/yannis_dyn/outputs/l1632f21b6396m014m070xig3000xiq3000b"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1632f21b6396m014m070xig3000xiq3000b"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1632f21b6396m014m070xig3000xiq3000b"

# executable="su3_rhmc_naive_a_dbl_gcc12openmpi4_20250421"
executable="su3_rhmd_naive_a_dbl_gcc12openmpi4_20250410"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="x30dynb"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

