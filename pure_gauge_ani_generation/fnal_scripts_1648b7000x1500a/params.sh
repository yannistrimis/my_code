
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=300
n_of_sub=2

nx=16
ny=16
nz=16
nt=48

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=4.66667 #in the MILC colde this appears first
beta_t=10.50000 #and this appears second

beta_name="7000"
xi_0_name="1500"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="1648b7000x1500a"
lat_name="l1648b7000x1500a"
out_name="out1648b7000x1500a"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1648b7000x1500a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1648b7000x1500a"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl1648b7000x1500a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl1648b7000x1500a"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="16:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="t15_13"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

