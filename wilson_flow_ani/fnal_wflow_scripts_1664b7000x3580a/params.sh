
#!/bin/bash

cluster=fnal

n_of_lat=100
n_of_sub=5

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b7000x3580a"
out_name="wflow1664b7000x3580xf400a_dt0.015625"

xi_f=4.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b7000x3580a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1664b7000x3580a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl1664b7000x3580a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl1664b7000x3580a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="12:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="wf358"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

