
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1000
n_of_sub=5

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

beta_s=2.14401 #in the MILC colde this appears first
beta_t=26.55165 #and this appears second

beta_name="754499"
xi_0_name="351911"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="2080b754499x351911a"
lat_name="l2080b754499x351911a"
out_name="out2080b754499x351911a"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l2080b754499x351911a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2080b754499x351911a"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl2080b754499x351911a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl2080b754499x351911a"

executable="su3_ora_symzk0_a_dbl_gcc12openmpi4_20231201"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="125"
sbatch_jobname="175tc"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

