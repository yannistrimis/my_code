#!/bin/bash

init_seed=1158
n_of_lat=2

nx=16
ny=16
nz=16
nt=16

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=6.850 #in the MILC colde this appears first
beta_t=6.850 #and this appears second

beta_name="6850"
xi_0_name="100"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS FOR SYMANZIK
qhb_steps=1

stream="a"

ensemble="${nx}${nt}b${beta_name}x${xi_0_name}${stream}"
lat_name="l${ensemble}"
out_name="out${ensemble}"

directory="/home/trimisio/lattices/${lat_name}"
out_dir="/home/trimisio/outputs/${lat_name}"
path_build="/home/trimisio/all/comm_code/fnal_code/pure_gauge_ani_generation/build"
run_dir="/home/trimisio/runs/rungen${lat_name}"
submit_dir="/home/trimisio/submits/subgen${lat_name}"

sbatch_time="00:30:00"
sbatch_nodes=1
sbatch_tasks=4
sbatch_jobname="test"
sbatch_module="intel"

erase="no"
