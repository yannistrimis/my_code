
#!/bin/bash

cluster=nersc

first_lattice=1

n_of_lat=1
n_of_sub=1

nx=64
ny=64
nz=64
nt=128

lat_name="l64128b858814x100000h"
out_name="wflow64128b858814x100000h_xf100_dt0.0078125"

xi_f=1.0

flow_action="wilson"
exp_order="16"
dt="0.0078125"
stoptime="1.0"


directory="/global/cfs/projectdirs/m1416/yannis_puregauge/lattices/l64128b858814x100000h"
out_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/outputs/l64128b858814x100000h"
path_build="/global/homes/t/trimisio/my_code/wilson_flow_ani/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/runwflowl64128b858814x100000h_xf100"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/subwflowl64128b858814x100000h_xf100"

executable="wilson_flow_bbb_a_dbl_cray_20250520"

sbatch_time="20:00:00"
sbatch_nodes="1"
sbatch_ntasks="1"
sbatch_jobname="a04wfl1"

