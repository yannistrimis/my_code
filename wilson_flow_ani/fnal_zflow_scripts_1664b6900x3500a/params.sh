
#!/bin/bash

cluster=fnal

n_of_lat=50
n_of_sub=4

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b6900x3500a"
out_name="zflow1664b6900x3500xf400a_dt0.015625"

xi_f=4.00

flow_action="zeuthen"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b6900x3500a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1664b6900x3500a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runzflowl1664b6900x3500a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subzflowl1664b6900x3500a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="12:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="z3500"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

