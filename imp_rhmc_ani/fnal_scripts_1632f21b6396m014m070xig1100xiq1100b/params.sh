
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
xiq=1.10

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=200
traj_between_meas=1
microcanonical_time_step=0.0625
steps_per_trajectory=16

ensemble="1632f21b6396m014m070xig1100xiq1100b"
lat_name="l1632f21b6396m014m070xig1100xiq1100b"
out_name="out1632f21b6396m014m070xig1100xiq1100b"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1632f21b6396m014m070xig1100xiq1100b"
out_dir="/project/ahisq/yannis_dyn/outputs/l1632f21b6396m014m070xig1100xiq1100b"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1632f21b6396m014m070xig1100xiq1100b"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1632f21b6396m014m070xig1100xiq1100b"

# executable="su3_rhmc_hisq_a_dbl_gcc12openmpi4_20250127"
executable="su3_rhmd_hisq_a_dbl_gcc12openmpi4_20250204"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="x1.1b"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

