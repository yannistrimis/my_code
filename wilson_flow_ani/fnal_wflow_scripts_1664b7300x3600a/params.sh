
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=100
n_of_sub=4

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b7300x3600a"
out_name="wflow1664b7300x3600xf400a_dt0.015625"

xi_f=4.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.0"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b7300x3600a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1664b7300x3600a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl1664b7300x3600a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl1664b7300x3600a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="6:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="w3600"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

