
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=48

beta_s=4.26400
beta_t=9.59400
xiq=1.5

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.04545
steps_per_trajectory=22

ensemble="1648f21b6396m014m070xig1500xiq1500a"
lat_name="l1648f21b6396m014m070xig1500xiq1500a"
out_name="out1648f21b6396m014m070xig1500xiq1500a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1648f21b6396m014m070xig1500xiq1500a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1648f21b6396m014m070xig1500xiq1500a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1648f21b6396m014m070xig1500xiq1500a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1648f21b6396m014m070xig1500xiq1500a"

# executable="su3_rhmc_naive_a_dbl_gcc12openmpi4_20250421"
executable="su3_rhmd_naive_a_dbl_gcc12openmpi4_20250410"

sbatch_time="10:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="x15dyn"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

