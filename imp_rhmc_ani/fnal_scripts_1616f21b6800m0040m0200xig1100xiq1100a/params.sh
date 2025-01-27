
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=16

beta_s=6.18182
beta_t=7.48000
xiq=1.10

dyn_mass_1=0.004
dyn_mass_2=0.02

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.05
steps_per_trajectory=20

ensemble="1616f21b6800m0040m0200xig1100xiq1100a"
lat_name="l1616f21b6800m0040m0200xig1100xiq1100a"
out_name="out1616f21b6800m0040m0200xig1100xiq1100a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1616f21b6800m0040m0200xig1100xiq1100a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1616f21b6800m0040m0200xig1100xiq1100a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1616f21b6800m0040m0200xig1100xiq1100a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1616f21b6800m0040m0200xig1100xiq1100a"

executable="su3_rhmc_hisq_a_dbl_gcc12openmpi4_20250127"

sbatch_time="22:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="rhmc_a"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

