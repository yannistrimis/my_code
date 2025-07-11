
#!/bin/bash

cluster=icer

first_lattice=101

n_of_lat=1000
n_of_sub=3

nx=20
ny=20
nz=20
nt=80

lat_name="l2080b7580x3625a"
out_name="wflow2080b7580x3625a_xf400_dt0.015625"

xi_f=4.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="12"


directory="/mnt/scratch/trimisio/lattices/l2080b7580x3625a"
out_dir="/mnt/home/trimisio/outputs/l2080b7580x3625a"
path_build="/mnt/home/trimisio/my_code/wilson_flow_ani/build"
run_dir="/mnt/scratch/trimisio/runs/runwflowl2080b7580x3625a_xf400"
submit_dir="/mnt/home/trimisio/submits/subwflowl2080b7580x3625a_xf400"

executable="wilson_flow_bbb_a_dbl_GCC12OpenMPI4_20250422"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks_per_node="NA"
sbatch_ntasks="128"
sbatch_jobname="fl3625"
sbatch_module1="GCC/12"
sbatch_module2="OpenMPI/4"

