
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=10
n_of_sub=1

nx=20
ny=20
nz=20
nt=320

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=1.05324 #in the MILC colde this appears first
beta_t=50.04686 #and this appears second

beta_name="726025"
xi_0_name="689327"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="20320b726025x689327a"
lat_name="l20320b726025x689327a"
out_name="out20320b726025x689327a"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l20320b726025x689327a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l20320b726025x689327a"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl20320b726025x689327a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl20320b726025x689327a"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="20:00:00"
sbatch_nodes="5"
sbatch_ntasks="200"
sbatch_jobname="g8"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

