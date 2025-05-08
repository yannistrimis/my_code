
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=32

beta_s=5.81455
beta_t=7.03560
xiq=1.1

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.05
steps_per_trajectory=20

ensemble="1632f21b6396m014m070xig1100xiq1100a"
lat_name="l1632f21b6396m014m070xig1100xiq1100a"
out_name="out1632f21b6396m014m070xig1100xiq1100a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1632f21b6396m014m070xig1100xiq1100a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1632f21b6396m014m070xig1100xiq1100a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1632f21b6396m014m070xig1100xiq1100a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1632f21b6396m014m070xig1100xiq1100a"

executable="su3_rhmd_hisq_a_dbl_gcc12openmpi4_20250508"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="ahisq11"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

