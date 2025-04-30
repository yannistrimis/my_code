
#!/bin/bash

cluster=fnal

first_lattice=201

n_of_lat=200
n_of_sub=1

nx=16
ny=16
nz=16
nt=48

lat_name="l1648f21b6396m014m070xig1500xiq1500a"
out_name="wflow1648f21b6396m014m070xig1500xiq1500xf150a_dt0.015625"

xi_f=1.50

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="10.0"


directory="/lustre1/ahisq/yannis_dyn/lattices/l1648f21b6396m014m070xig1500xiq1500a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1648f21b6396m014m070xig1500xiq1500a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/runwflowl1648f21b6396m014m070xig1500xiq1500a"
submit_dir="/project/ahisq/yannis_dyn/submits/subwflowl1648f21b6396m014m070xig1500xiq1500a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="15dywfl"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

