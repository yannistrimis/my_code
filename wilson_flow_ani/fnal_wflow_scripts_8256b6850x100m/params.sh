
#!/bin/bash

cluster=fnal

first_lattice=1

n_of_lat=4
n_of_sub=1

nx=8
ny=8
nz=8
nt=256

lat_name="l8256b6850x100m"
out_name="wflow8256b6850x100xf100m_dt0.015625"

xi_f=1.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l8256b6850x100m"
out_dir="/project/ahisq/yannis_puregauge/outputs/l8256b6850x100m"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl8256b6850x100m"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl8256b6850x100m"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="6:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="sc256"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

