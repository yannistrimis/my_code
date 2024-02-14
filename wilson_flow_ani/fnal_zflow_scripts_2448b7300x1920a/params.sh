
#!/bin/bash

cluster=fnal

n_of_lat=100
n_of_sub=5

nx=24
ny=24
nz=24
nt=48

lat_name="l2448b7300x1920a"
out_name="zflow2448b7300x1920xf200a_dt0.015625"

xi_f=2.00

flow_action="zeuthen"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l2448b7300x1920a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2448b7300x1920a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runzflowl2448b7300x1920a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subzflowl2448b7300x1920a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="12:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="zfl192"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

