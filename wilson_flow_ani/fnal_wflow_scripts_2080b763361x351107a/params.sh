
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=500
n_of_sub=4

nx=20
ny=20
nz=20
nt=80

lat_name="l2080b763361x351107a"
out_name="wflow2080b763361x351107xf400a_dt0.015625"

xi_f=4.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="7.0"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l2080b763361x351107a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2080b763361x351107a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl2080b763361x351107a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl2080b763361x351107a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="w2.0tc"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

