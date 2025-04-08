
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=200
n_of_sub=2

nx=24
ny=24
nz=24
nt=48

lat_name="l2448b748098x182579a"
out_name="wflow2448b748098x182579xf200a_dt0.015625"

xi_f=2.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="7.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l2448b748098x182579a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2448b748098x182579a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl2448b748098x182579a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl2448b748098x182579a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="t175w12"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

