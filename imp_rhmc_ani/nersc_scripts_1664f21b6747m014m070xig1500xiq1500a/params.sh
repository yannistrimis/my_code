
#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS

cluster=nersc

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=64

beta_s=4.49800
beta_t=10.12050
xiq=1.5

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.04167
steps_per_trajectory=24

ensemble="1664f21b6747m014m070xig1500xiq1500a"
lat_name="l1664f21b6747m014m070xig1500xiq1500a"
out_name="out1664f21b6747m014m070xig1500xiq1500a"


directory="/global/cfs/projectdirs/m1416/yannis_dyn/lattices/l1664f21b6747m014m070xig1500xiq1500a"
out_dir="/global/cfs/projectdirs/m1416/yannis_dyn/outputs/l1664f21b6747m014m070xig1500xiq1500a"
path_build="/global/homes/t/trimisio/my_code/imp_rhmc_ani/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_dyn/runs/rungenl1664f21b6747m014m070xig1500xiq1500a"
submit_dir="/global/cfs/projectdirs/m1416/yannis_dyn/submits/subgenl1664f21b6747m014m070xig1500xiq1500a"

executable="su3_rhmd_hisq_a_dbl_crayintel_20250930"
# executable="su3_rhmc_hisq_a_dbl_crayintel_20250930"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="ahisq15"

