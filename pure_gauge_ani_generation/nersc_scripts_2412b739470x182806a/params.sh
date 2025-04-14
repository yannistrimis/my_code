
#!/bin/bash

cluster=nersc

init_seed=1158
n_of_lat=10000
n_of_sub=4

nx=24
ny=24
nz=24
nt=12

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=4.04511 #in the MILC colde this appears first
beta_t=13.51796 #and this appears second

beta_name="739470"
xi_0_name="182806"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="2412b739470x182806a"
lat_name="l2412b739470x182806a"
out_name="out2412b739470x182806a"


directory="/global/cfs/projectdirs/m1416/yannis_puregauge/lattices/l2412b739470x182806a"
out_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/outputs/l2412b739470x182806a"
path_build="/global/homes/t/trimisio/my_code/pure_gauge_ani_generation/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/rungenl2412b739470x182806a"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/subgenl2412b739470x182806a"

executable="su3_ora_symzk0_a_dbl_crayintel_20250404"

sbatch_time="20:00:00"
sbatch_nodes="1"
sbatch_ntasks_per_node="64"
sbatch_ntasks="64"
sbatch_jobname="150tc12nt"

