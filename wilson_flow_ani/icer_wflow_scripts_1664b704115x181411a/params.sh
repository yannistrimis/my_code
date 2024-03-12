
#!/bin/bash

cluster=icer

first_lattice=101

n_of_lat=100
n_of_sub=5

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b704115x181411a"
out_name="wflow1664b704115x181411xf200a_dt0.015625"

xi_f=2.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.0"


directory="/mnt/scratch/trimisio/lattices/l1664b704115x181411a"
out_dir="/mnt/home/trimisio/outputs/l1664b704115x181411a"
path_build="/mnt/home/trimisio/my_code/wilson_flow_ani/build"
run_dir="/mnt/scratch/trimisio/runs/runwflowl1664b704115x181411a"
submit_dir="/mnt/home/trimisio/submits/subwflowl1664b704115x181411a"

executable="region_flow_bbb_a_dbl_gompi2020b_20240213"

sbatch_time="6:00:00"
sbatch_ntasks="128"
sbatch_jobname="wf200"
sbatch_module="gompi/2020b"

