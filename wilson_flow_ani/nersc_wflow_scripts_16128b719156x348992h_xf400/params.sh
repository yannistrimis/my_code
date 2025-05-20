
#!/bin/bash

cluster=nersc

first_lattice=101

n_of_lat=1000
n_of_sub=2

nx=16
ny=16
nz=16
nt=128

lat_name="l16128b719156x348992h"
out_name="wflow16128b719156x348992h_xf400_dt0.015625"

xi_f=4.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.0"


directory="/global/cfs/projectdirs/m1416/yannis_puregauge/lattices/l16128b719156x348992h"
out_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/outputs/l16128b719156x348992h"
path_build="/global/homes/t/trimisio/my_code/wilson_flow_ani/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/runwflowl16128b719156x348992h_xf400"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/subwflowl16128b719156x348992h_xf400"

executable="wilson_flow_bbb_a_dbl_cray_20250520"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="256"
sbatch_jobname="fl40"

