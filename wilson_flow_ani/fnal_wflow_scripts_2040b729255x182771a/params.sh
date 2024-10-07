
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=500
n_of_sub=2

nx=20
ny=20
nz=20
nt=40

lat_name="l2040b729255x182771a"
out_name="wflow2040b729255x182771xf200a_dt0.015625"

xi_f=2.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l2040b729255x182771a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2040b729255x182771a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl2040b729255x182771a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl2040b729255x182771a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="w1.5tc"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

