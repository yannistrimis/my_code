
#!/bin/bash

cluster=icer

first_lattice=300

n_of_lat=2
n_of_sub=1

nx=20
ny=20
nz=20
nt=320

lat_name="l20320b726025x689327a"
out_name="wflow20320b726025x689327a_xf800_dt0.015625"

xi_f=8.0

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="6"


directory="/mnt/scratch/trimisio/lattices/l20320b726025x689327a"
out_dir="/mnt/home/trimisio/outputs/l20320b726025x689327a"
path_build="/mnt/home/trimisio/my_code/wilson_flow_ani/build"
run_dir="/mnt/scratch/trimisio/runs/runwflowl20320b726025x689327a_xf800"
submit_dir="/mnt/home/trimisio/submits/subwflowl20320b726025x689327a_xf800"

executable="wilson_flow_bbb_a_dbl_GCC12OpenMPI4_20250422"

sbatch_time="20:00:00"
sbatch_nodes="5"
sbatch_ntasks_per_node="NA"
sbatch_ntasks="200"
sbatch_jobname="wfl8old"
sbatch_module1="GCC/12"
sbatch_module2="OpenMPI/4"

