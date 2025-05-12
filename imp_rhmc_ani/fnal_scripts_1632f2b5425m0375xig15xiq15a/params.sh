
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1000
n_of_sub=1

nx=16
ny=16
nz=16
nt=32

beta_s=3.61667
beta_t=8.13750
xiq=1.5

dyn_mass=0.0375
rationals_file="rationals.m0375"

warms=0
trajecs=5
traj_between_meas=1
microcanonical_time_step=0.04167
steps_per_trajectory=24

ensemble="1632f2b5425m0375xig15xiq15a"
lat_name="l1632f2b5425m0375xig15xiq15a"
out_name="out1632f2b5425m0375xig15xiq15a"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1632f2b5425m0375xig15xiq15a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1632f2b5425m0375xig15xiq15a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1632f2b5425m0375xig15xiq15a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1632f2b5425m0375xig15xiq15a"

executable="su3_rhmc_naive_plaq_a_dbl_gcc12openmpi4_20250430"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="run1"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

