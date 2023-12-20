
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=4
n_of_sub=1

nx=8
ny=8
nz=8
nt=256

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=6.85000 #in the MILC colde this appears first
beta_t=6.85000 #and this appears second

beta_name="6850"
xi_0_name="100"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="m"

ensemble="8256b6850x100m"
lat_name="l8256b6850x100m"
out_name="out8256b6850x100m"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l8256b6850x100m"
out_dir="/project/ahisq/yannis_puregauge/outputs/l8256b6850x100m"
path_build="/home/trimisio/all/comm_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl8256b6850x100m"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl8256b6850x100m"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="8:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="2sc128"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

