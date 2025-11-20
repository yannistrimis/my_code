
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=600
n_of_sub=8

nx=16
ny=16
nz=64
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

stream="zl"

ensemble="16128b719156x348992zl"
lat_name="l16128b719156x348992zl"
out_name="out16128b719156x348992zl"


directory="/lustre2/ahisq/yannis_puregauge/lattices/l16128b719156x348992zl"
out_dir="/project/ahisq/yannis_puregauge/outputs/l16128b719156x348992zl"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl16128b719156x348992zl"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl16128b719156x348992zl"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="20:00:00"
sbatch_nodes="7"
sbatch_ntasks="256"
sbatch_jobname="4gzl"
#sbatch_module1="gcc/12"
#sbatch_module2="openmpi/4"

