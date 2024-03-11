
#!/bin/bash

cluster=fnal

n_of_lat=5
n_of_sub=1

nx=20
ny=20
nz=20
nt=160

lat_name="l20160b7298x6867a"
out_name="wflow20160b7298x6867xf800a_dt0.015625"

xi_f=8.00

flow_action="wilson"
exp_order="16"
dt="0.010"
stoptime="1.6"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l20160b7298x6867a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l20160b7298x6867a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl20160b7298x6867a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl20160b7298x6867a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="4:00:00"
sbatch_nodes="4"
sbatch_ntasks="100"
sbatch_jobname="w800"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

