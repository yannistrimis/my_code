
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=100
n_of_sub=4

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b7200x3200a"
out_name="sflow1664b7200x3200xf400a_dt0.015625"

xi_f=4.00

flow_action="symanzik"
exp_order="16"
dt="0.015625"
stoptime="3.0"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b7200x3200a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1664b7200x3200a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runsflowl1664b7200x3200a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subsflowl1664b7200x3200a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="10:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="s3200"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

