
#!/bin/bash

cluster=icer

n_of_lat=100
n_of_sub=5

nx=20
ny=20
nz=20
nt=40

lat_name="l2040b7200x1920a"
out_name="zflow2040b7200x1920xf200a_dt0.015625"

xi_f=2.00

flow_action="zeuthen"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/mnt/scratch/trimisio/lattices/l2040b7200x1920a"
out_dir="/mnt/home/trimisio/outputs/l2040b7200x1920a"
path_build="/mnt/home/trimisio/my_code/wilson_flow_ani/build"
run_dir="/mnt/scratch/trimisio/runs/runzflowl2040b7200x1920a"
submit_dir="/mnt/home/trimisio/submits/subzflowl2040b7200x1920a"

executable="region_flow_bbb_a_dbl_gompi2020b_20240213"

sbatch_time="08:00:00"
sbatch_ntasks="128"
sbatch_jobname="zfl192"
sbatch_module="gompi/2020b"

