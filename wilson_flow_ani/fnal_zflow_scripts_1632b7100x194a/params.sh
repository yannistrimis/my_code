
#!/bin/bash

cluster=fnal

n_of_lat=252
n_of_sub=2

nx=16
ny=16
nz=16
nt=32

lat_name="l1632b7100x194a"
out_name="zflow1632b7100x194xf200a_dt0.015625"

xi_f=2.00

flow_action="zeuthen"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1632b7100x194a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1632b7100x194a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runzflowl1632b7100x194a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subzflowl1632b7100x194a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="05:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="zfl194"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

