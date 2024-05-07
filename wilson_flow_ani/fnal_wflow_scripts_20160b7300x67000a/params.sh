
#!/bin/bash

cluster=fnal

first_lattice=51

n_of_lat=20
n_of_sub=5

nx=20
ny=20
nz=20
nt=160

lat_name="l20160b7300x67000a"
out_name="wflow20160b7300x67000xf800a_dt0.015625"

xi_f=8.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.0"


directory="/project/ahisq/puregauge/lattices/l20160b7300x67000a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l20160b7300x67000a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl20160b7300x67000a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl20160b7300x67000a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="10:00:00"
sbatch_nodes="4"
sbatch_ntasks="100"
sbatch_jobname="w6700"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

