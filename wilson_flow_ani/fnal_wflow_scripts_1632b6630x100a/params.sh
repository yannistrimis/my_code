
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=101
n_of_sub=4

nx=16
ny=16
nz=16
nt=32

lat_name="l1632b6630x100a"
out_name="wflow1632b6630x100xf100a_dt0.015625"

xi_f=1.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1632b6630x100a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1632b6630x100a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl1632b6630x100a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl1632b6630x100a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="10:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="1w6630"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

