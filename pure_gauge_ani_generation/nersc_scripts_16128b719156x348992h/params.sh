
#!/bin/bash

cluster=nersc

init_seed=1158
n_of_lat=400
n_of_sub=2

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
trajecs=5
traj_between_meas=1
steps_per_trajectory=128
microcanonical_time_step=0.0078125
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK

stream="h"

ensemble="16128b719156x348992h"
lat_name="l16128b719156x348992h"
out_name="out16128b719156x348992h"


directory="/global/cfs/projectdirs/m1416/yannis_puregauge/lattices/l16128b719156x348992h"
out_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/outputs/l16128b719156x348992h"
path_build="/global/homes/t/trimisio/my_code/pure_gauge_ani_generation/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/rungenl16128b719156x348992h"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/subgenl16128b719156x348992h"

# executable="su3_hmc_symzk0_a_dbl_crayintel_20250501"
executable="su3_hmd_symzk0_a_dbl_crayintel_20250502"

sbatch_time="40:00:00"
sbatch_nodes="4"
sbatch_ntasks="256"
sbatch_jobname="hmcxg4"

