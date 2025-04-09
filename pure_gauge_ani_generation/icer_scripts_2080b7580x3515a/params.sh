
#!/bin/bash

cluster=icer

init_seed=1158
n_of_lat=1000
n_of_sub=2

nx=20
ny=20
nz=20
nt=80

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=2.15647 #in the MILC colde this appears first
beta_t=26.64370 #and this appears second

beta_name="7580"
xi_0_name="3515"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="2080b7580x3515a"
lat_name="l2080b7580x3515a"
out_name="out2080b7580x3515a"


directory="/mnt/scratch/trimisio/lattices/l2080b7580x3515a"
out_dir="/mnt/home/trimisio/outputs/l2080b7580x3515a"
path_build="/mnt/home/trimisio/my_code/pure_gauge_ani_generation/build"
run_dir="/mnt/scratch/trimisio/runs/rungenl2080b7580x3515a"
submit_dir="/mnt/home/trimisio/submits/subgenl2080b7580x3515a"

executable="su3_ora_symzk0_a_dbl_GCC12OpenMPI4_20250321"

sbatch_time="20:00:00"
sbatch_nodes="3"
sbatch_ntasks_per_node="25"
sbatch_ntasks="100"
sbatch_jobname="tun4_2"
sbatch_module1="GCC/12"
sbatch_module2="OpenMPI/4"

