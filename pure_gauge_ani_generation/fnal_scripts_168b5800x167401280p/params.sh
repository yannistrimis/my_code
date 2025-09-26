#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1000
n_of_sub=8

nx=16
ny=16
nz=16
nt=8

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta.

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=3.46473 #in the MILC colde this appears first
beta_t=9.70927 #and this appears second

beta_name="5800"
xi_0_name="167401280"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="p"

ensemble="168b5800x167401280p"
lat_name="l168b5800x167401280p"
out_name="out168b5800x167401280p"


directory="/lustre2/ahisq/yannis_puregauge/lattices/l168b5800x167401280p"
out_dir="/project/ahisq/yannis_puregauge/outputs/l168b5800x167401280p"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl168b5800x167401280p"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl168b5800x167401280p"

executable="su3_ora_a_dbl_gcc12openmpi4_20250926"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="plaqNt8"
#sbatch_module1="gcc/12"
#sbatch_module2="openmpi/4"

