
#!/bin/bash

cluster=icer

first_lattice=51

n_of_lat=20
n_of_sub=5

nx=20
ny=20
nz=20
nt=160

lat_name="l20160b7200x7100a"
out_name="wflow20160b7200x7100xf800a_dt0.015625"

xi_f=8.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.0"


directory="/mnt/scratch/trimisio/lattices/l20160b7200x7100a"
out_dir="/mnt/home/trimisio/outputs/l20160b7200x7100a"
path_build="/mnt/home/trimisio/my_code/wilson_flow_ani/build"
run_dir="/mnt/scratch/trimisio/runs/runwflowl20160b7200x7100a"
submit_dir="/mnt/home/trimisio/submits/subwflowl20160b7200x7100a"

executable="region_flow_bbb_a_dbl_gompi2020b_20240213"

sbatch_time="10:00:00"
sbatch_ntasks="100"
sbatch_jobname="w7100"
sbatch_module="gompi/2020b"

