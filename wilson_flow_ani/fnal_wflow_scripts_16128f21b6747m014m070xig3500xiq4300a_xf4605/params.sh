
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=200
n_of_sub=1

nx=16
ny=16
nz=16
nt=128

lat_name="l16128f21b6747m014m070xig3500xiq4300a"
out_name="wflow16128f21b6747m014m070xig3500xiq4300a_xf4605_dt0.015625"

xi_f=4.605

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="6.0"


directory="/lustre1/ahisq/yannis_dyn/lattices/l16128f21b6747m014m070xig3500xiq4300a"
out_dir="/project/ahisq/yannis_dyn/outputs/l16128f21b6747m014m070xig3500xiq4300a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/runwflowl16128f21b6747m014m070xig3500xiq4300a_xf4605"
submit_dir="/project/ahisq/yannis_dyn/submits/subwflowl16128f21b6747m014m070xig3500xiq4300a_xf4605"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="430fl"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

