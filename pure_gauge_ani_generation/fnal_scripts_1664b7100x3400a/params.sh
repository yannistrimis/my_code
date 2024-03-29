
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=50
n_of_sub=7

nx=16
ny=16
nz=16
nt=64

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=2.08824 #in the MILC colde this appears first
beta_t=24.14000 #and this appears second

beta_name="7100"
xi_0_name="3400"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="1664b7100x3400a"
lat_name="l1664b7100x3400a"
out_name="out1664b7100x3400a"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b7100x3400a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1664b7100x3400a"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl1664b7100x3400a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl1664b7100x3400a"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="10:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="g3400"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

