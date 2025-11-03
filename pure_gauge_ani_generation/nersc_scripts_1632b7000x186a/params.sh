
#!/bin/bash

cluster=nersc

init_seed=1158
n_of_lat=1000
n_of_sub=2

nx=16
ny=16
nz=16
nt=32

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=3.76344 #in the MILC colde this appears first
beta_t=13.02000 #and this appears second

beta_name="7000"
xi_0_name="186"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="a"

ensemble="1632b7000x186a"
lat_name="l1632b7000x186a"
out_name="out1632b7000x186a"


directory="/global/cfs/projectdirs/m1416/yannis_puregauge/lattices/l1632b7000x186a"
out_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/outputs/l1632b7000x186a"
path_build="/global/homes/t/trimisio/my_code/pure_gauge_ani_generation/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/rungenl1632b7000x186a"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/subgenl1632b7000x186a"

executable="su3_ora_symzk0_a_dbl_crayintel_20250404"

sbatch_time="20:00:00"
sbatch_nodes="1"
sbatch_ntasks="128"
sbatch_jobname="186"

