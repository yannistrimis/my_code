
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=400
n_of_sub=1

nx=16
ny=16
nz=16
nt=48

lat_name="l1648b7100x1500a"
out_name="wflow1648b7100x1500xf150a_dt0.015625"

xi_f=1.50

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1648b7100x1500a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1648b7100x1500a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl1648b7100x1500a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl1648b7100x1500a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="16:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="w15_3c"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

