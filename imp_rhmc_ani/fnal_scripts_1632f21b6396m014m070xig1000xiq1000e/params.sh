
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=32

beta=6.39600

dyn_mass_1=0.014
dyn_mass_2=0.07

warms=0
trajecs=500
traj_between_meas=1
microcanonical_time_step=0.01
steps_per_trajectory=20

ensemble="1632f21b6396m014m070xig1000xiq1000e"
lat_name="l1632f21b6396m014m070xig1000xiq1000e"
out_name="out1632f21b6396m014m070xig1000xiq1000e"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1632f21b6396m014m070xig1000xiq1000e"
out_dir="/project/ahisq/yannis_dyn/outputs/l1632f21b6396m014m070xig1000xiq1000e"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1632f21b6396m014m070xig1000xiq1000e"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1632f21b6396m014m070xig1000xiq1000e"

executable="su3_rhmc_hisq_dbl_gcc12openmpi4_20250204_isoapp2"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="rhmc_e"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

