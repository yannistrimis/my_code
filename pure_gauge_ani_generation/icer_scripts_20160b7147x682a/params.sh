
#!/bin/bash

cluster=icer

init_seed=1158
n_of_lat=1000
n_of_sub=8

nx=20
ny=20
nz=20
nt=160

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=1.04795 #in the MILC colde this appears first
beta_t=48.74254 #and this appears second

beta_name="7147"
xi_0_name="682"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="20160b7147x682a"
lat_name="l20160b7147x682a"
out_name="out20160b7147x682a"


directory="/mnt/scratch/trimisio/lattices/l20160b7147x682a"
out_dir="/mnt/home/trimisio/outputs/l20160b7147x682a"
path_build="/mnt/home/trimisio/my_code/pure_gauge_ani_generation/build"
run_dir="/mnt/scratch/trimisio/runs/rungenl20160b7147x682a"
submit_dir="/mnt/home/trimisio/submits/subgenl20160b7147x682a"

executable="su3_ora_symzk0_a_dbl_GCC12OpenMPI4_20250321"

sbatch_time="20:00:00"
sbatch_nodes="5"
sbatch_ntasks_per_node="NA"
sbatch_ntasks="200"
sbatch_jobname="8gen"
#sbatch_module1="GCC/12"
#sbatch_module2="OpenMPI/4"

