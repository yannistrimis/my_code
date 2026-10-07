
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=300
n_of_sub=2

nx=16
ny=16
nz=16
nt=16

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=8.05952 #in the MILC colde this appears first
beta_t=5.68680 #and this appears second

beta_name="677000"
xi_0_name="084000"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="1616b677000x084000a"
lat_name="l1616b677000x084000a"
out_name="out1616b677000x084000a"


directory="/lustre2/ahisq/yannis_puregauge/lattices/l1616b677000x084000a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1616b677000x084000a"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl1616b677000x084000a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl1616b677000x084000a"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="x09e2"
#sbatch_module1="gcc/12"
#sbatch_module2="openmpi/4"

