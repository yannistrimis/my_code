#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1
n_of_sub=1

nx=10
ny=20
nz=20
nt=20

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=3.89987 #in the MILC colde this appears first
beta_t=12.87395 #and this appears second

beta_name="708567"
xi_0_name="181690"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="2010b708567x181690a"
lat_name="l2010b708567x181690a"
out_name="out2010b708567x181690a"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l2010b708567x181690a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2010b708567x181690a"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl2010b708567x181690a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl2010b708567x181690a"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="01:00:00"
sbatch_nodes="1"
sbatch_ntasks="15"
sbatch_jobname="tc1nt10"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

