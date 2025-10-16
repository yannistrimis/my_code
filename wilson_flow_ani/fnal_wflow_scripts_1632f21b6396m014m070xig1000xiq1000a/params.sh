
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=500
n_of_sub=1

nx=16
ny=16
nz=16
nt=32

lat_name="l1632f21b6396m014m070xig1000xiq1000a"
out_name="wflow1632f21b6396m014m070xig1000xiq1000a_xf100_dt0.015625"

xi_f=1.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="12.0"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1632f21b6396m014m070xig1000xiq1000a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1632f21b6396m014m070xig1000xiq1000a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/runwflowl1632f21b6396m014m070xig1000xiq1000a"
submit_dir="/project/ahisq/yannis_dyn/submits/subwflowl1632f21b6396m014m070xig1000xiq1000a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="1dynfl"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

