
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=50
n_of_sub=1

nx=16
ny=16
nz=16
nt=128

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=2.06067 #in the MILC colde this appears first
beta_t=25.09797 #and this appears second

beta_name="719156"
xi_0_name="348992"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="16128b719156x348992a"
lat_name="l16128b719156x348992a"
out_name="out16128b719156x348992a"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l16128b719156x348992a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l16128b719156x348992a"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl16128b719156x348992a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl16128b719156x348992a"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="10:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="g4"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

