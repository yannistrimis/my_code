
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=1000
n_of_sub=2

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b7100x3500a"
out_name="zflow1664b7100x3500a_xf400_dt0.0078125"

xi_f=4.0

flow_action="zeuthen"
exp_order="16"
dt="0.0078125"
stoptime="6"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b7100x3500a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1664b7100x3500a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runzflowl1664b7100x3500a_xf400"
submit_dir="/project/ahisq/yannis_puregauge/submits/subzflowl1664b7100x3500a_xf400"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="a20wfl4"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

