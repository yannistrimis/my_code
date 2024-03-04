
#!/bin/bash

cluster=fnal

n_of_lat=10
n_of_sub=1

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b6900x3220a"
out_name="zflow1664b6900x3220xf400a_dt0.015625"

xi_f=4.00

flow_action="zeuthen"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b6900x3220a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1664b6900x3220a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runzflowl1664b6900x3220a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subzflowl1664b6900x3220a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="4:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="zf322"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

