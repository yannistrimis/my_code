
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=1000
n_of_sub=4

nx=16
ny=16
nz=16
nt=128

lat_name="l16128b719156x348992a"
out_name="wflow16128b719156x348992xf400a_dt0.0078125"

xi_f=4.00

flow_action="wilson"
exp_order="16"
dt="0.0078125"
stoptime="4.0"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l16128b719156x348992a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l16128b719156x348992a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl16128b719156x348992a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl16128b719156x348992a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="w016x40"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

