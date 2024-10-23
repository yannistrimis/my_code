
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=500
n_of_sub=2

nx=12
ny=12
nz=24
nt=96

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=1.83355 #in the MILC colde this appears first
beta_t=18.03200 #and this appears second

beta_name="575"
xi_0_name="3136"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="p"

ensemble="1296b575x3136p"
lat_name="l1296b575x3136p"
out_name="out1296b575x3136p"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1296b575x3136p"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1296b575x3136p"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl1296b575x3136p"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl1296b575x3136p"

executable="su3_ora_plaq_a_dbl_gcc12openmpi4_20241002"

sbatch_time="20:00:00"
sbatch_nodes="3"
sbatch_ntasks="96"
sbatch_jobname="nomcomp"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

