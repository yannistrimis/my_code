
#!/bin/bash

cluster=fnal

first_lattice=1

n_of_lat=4
n_of_sub=1

nx=8
ny=8
nz=8
nt=128

lat_name="l8128b6850x100l"
out_name="wflow8128b6850x100xf100l_dt0.015625"

xi_f=1.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l8128b6850x100l"
out_dir="/project/ahisq/yannis_puregauge/outputs/l8128b6850x100l"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl8128b6850x100l"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl8128b6850x100l"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="6:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="sc128"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

