
#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=16
ny=16
nz=16
nt=64

beta_s=3.96882
beta_t=11.46990
xiq=1.70

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=100
traj_between_meas=1
microcanonical_time_step=0.041666666666666664
steps_per_trajectory=24

ensemble="1664f21b6747m014m070xig1700xiq1700a"
lat_name="l1664f21b6747m014m070xig1700xiq1700a"
out_name="out1664f21b6747m014m070xig1700xiq1700a"


directory="/lustre2/ahisq/yannis_dyn/lattices/l1664f21b6747m014m070xig1700xiq1700a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1664f21b6747m014m070xig1700xiq1700a"
path_build="/home/trimisio/all/my_code/imp_rhmc_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/rungenl1664f21b6747m014m070xig1700xiq1700a"
submit_dir="/project/ahisq/yannis_dyn/submits/subgenl1664f21b6747m014m070xig1700xiq1700a"

executable="su3_rhmd_hisq_a_dbl_gcc12openmpi4_20250508"
# executable="su3_rhmc_hisq_a_dbl_gcc12openmpi4_20250508"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="7m1717a"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

