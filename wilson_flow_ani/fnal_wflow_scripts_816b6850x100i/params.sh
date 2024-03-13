
#!/bin/bash

cluster=fnal

first_lattice=1

n_of_lat=4
n_of_sub=1

nx=8
ny=8
nz=8
nt=16

lat_name="l816b6850x100i"
out_name="wflow816b6850x100xf100i_dt0.015625"

xi_f=1.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l816b6850x100i"
out_dir="/project/ahisq/yannis_puregauge/outputs/l816b6850x100i"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl816b6850x100i"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl816b6850x100i"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="6:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="sc16"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

