
#!/bin/bash
#DON'T FORGET TO CHANGE EXE FROM HMD TO HMC U DUMBASS

cluster=nersc

init_seed=1158
n_of_lat=1
n_of_sub=10

nx=20
ny=20
nz=20
nt=320

beta_s=1.05324
beta_t=50.04686
xiq=8.0

dyn_mass_1=0.014
dyn_mass_2=0.07
rationals_file="rationals.m014m070"

warms=0
trajecs=4
traj_between_meas=1
microcanonical_time_step=0.04167
steps_per_trajectory=24

ensemble="20320f21b726025m014m070xig689327xiq8000a"
lat_name="l20320f21b726025m014m070xig689327xiq8000a"
out_name="out20320f21b726025m014m070xig689327xiq8000a"


directory="/global/cfs/projectdirs/m1416/yannis_dyn/lattices/l20320f21b726025m014m070xig689327xiq8000a"
out_dir="/global/cfs/projectdirs/m1416/yannis_dyn/outputs/l20320f21b726025m014m070xig689327xiq8000a"
path_build="/global/homes/t/trimisio/my_code/imp_rhmc_ani/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_dyn/runs/rungenl20320f21b726025m014m070xig689327xiq8000a"
submit_dir="/global/cfs/projectdirs/m1416/yannis_dyn/submits/subgenl20320f21b726025m014m070xig689327xiq8000a"

executable="su3_rhmd_hisq_a_dbl_crayintel_20250930"
# executable="su3_rhmc_hisq_a_dbl_crayintel_20250930"

sbatch_time="03:00:00"
sbatch_nodes="2"
sbatch_ntasks="256"
sbatch_jobname="ahisq8"

