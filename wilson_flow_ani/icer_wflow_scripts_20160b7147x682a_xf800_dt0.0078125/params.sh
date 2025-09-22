
#!/bin/bash

cluster=icer

first_lattice=101

n_of_lat=1000
n_of_sub=4

nx=20
ny=20
nz=20
nt=160

lat_name="l20160b7147x682a"
out_name="wflow20160b7147x682a_xf800_dt0.0078125"

xi_f=8.0

flow_action="wilson"
exp_order="16"
dt="0.0078125"
stoptime="6"


directory="/mnt/scratch/trimisio/lattices/l20160b7147x682a"
out_dir="/mnt/home/trimisio/outputs/l20160b7147x682a"
path_build="/mnt/home/trimisio/my_code/wilson_flow_ani/build"
run_dir="/mnt/scratch/trimisio/runs/runwflowl20160b7147x682a_xf800_dt0.0078125"
submit_dir="/mnt/home/trimisio/submits/subwflowl20160b7147x682a_xf800_dt0.0078125"

executable="wilson_flow_bbb_a_dbl_GCC12OpenMPI4_20250422"

sbatch_time="20:00:00"
sbatch_nodes="5"
sbatch_ntasks_per_node="NA"
sbatch_ntasks="200"
sbatch_jobname="a20wfl8"
sbatch_module1="GCC/12"
sbatch_module2="OpenMPI/4"

