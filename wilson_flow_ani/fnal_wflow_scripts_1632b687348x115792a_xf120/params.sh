
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=300
n_of_sub=2

nx=16
ny=16
nz=16
nt=32

lat_name="l1632b687348x115792a"
out_name="wflow1632b687348x115792a_xf120_dt0.015625"

xi_f=1.20

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="4"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1632b687348x115792a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1632b687348x115792a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl1632b687348x115792a_xf120"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl1632b687348x115792a_xf120"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="flpg120"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

