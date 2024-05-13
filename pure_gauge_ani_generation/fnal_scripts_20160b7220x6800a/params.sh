
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=50
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

beta_s=1.06176 #in the MILC colde this appears first
beta_t=49.09600 #and this appears second

beta_name="7220"
xi_0_name="6800"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="20160b7220x6800a"
lat_name="l20160b7220x6800a"
out_name="out20160b7220x6800a"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l20160b7220x6800a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l20160b7220x6800a"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl20160b7220x6800a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl20160b7220x6800a"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="10:00:00"
sbatch_nodes="5"
sbatch_ntasks="200"
sbatch_jobname="g6800"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

