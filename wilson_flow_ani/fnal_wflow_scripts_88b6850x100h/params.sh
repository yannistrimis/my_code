
#!/bin/bash

cluster=fnal

first_lattice=1

n_of_lat=4
n_of_sub=1

nx=8
ny=8
nz=8
nt=8

lat_name="l88b6850x100h"
out_name="wflow88b6850x100xf100h_dt0.015625"

xi_f=1.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l88b6850x100h"
out_dir="/project/ahisq/yannis_puregauge/outputs/l88b6850x100h"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl88b6850x100h"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl88b6850x100h"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="6:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="sc8"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

