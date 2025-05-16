#!/bin/bash

cluster=nersc

init_seed=1158
n_of_lat=500
n_of_sub=3

nx=64
ny=64
nz=64
nt=128

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=8.58814 #in the MILC colde this appears first
beta_t=8.58814 #and this appears second

beta_name="858814"
xi_0_name="100000"

warms=0
trajecs=5
traj_between_meas=1
steps_per_trajectory=164
microcanonical_time_step=0.006097560975609756
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK

stream="h"

ensemble="64128b858814x100000h"
lat_name="l64128b858814x100000h"
out_name="out64128b858814x100000h"


directory="/global/cfs/projectdirs/m1416/yannis_puregauge/lattices/l64128b858814x100000h"
out_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/outputs/l64128b858814x100000h"
path_build="/global/homes/t/trimisio/my_code/pure_gauge_ani_generation/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/rungenl64128b858814x100000h"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/subgenl64128b858814x100000h"

executable="su3_hmc_symzk0_a_dbl_crayintel_20250501"
# executable="su3_hmd_symzk0_a_dbl_crayintel_20250502"

sbatch_time="47:00:00"
sbatch_nodes="4"
sbatch_ntasks="256"
sbatch_jobname="hmcxg1"

