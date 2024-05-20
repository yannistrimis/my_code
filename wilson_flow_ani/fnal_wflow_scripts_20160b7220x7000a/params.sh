
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=50
n_of_sub=8

nx=20
ny=20
nz=20
nt=160

lat_name="l20160b7220x7000a"
out_name="wflow20160b7220x7000xf800a_dt0.015625"

xi_f=8.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.0"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l20160b7220x7000a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l20160b7220x7000a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl20160b7220x7000a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl20160b7220x7000a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="10:00:00"
sbatch_nodes="5"
sbatch_ntasks="200"
sbatch_jobname="8w70"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

