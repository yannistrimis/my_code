
#!/bin/bash

cluster=fnal

first_lattice=101

n_of_lat=101
n_of_sub=4

nx=20
ny=20
nz=20
nt=320

lat_name="l20320b726025x689327a"
out_name="wflow20320b726025x689327xf800a_dt0.015625"

xi_f=8.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l20320b726025x689327a"
out_dir="/project/ahisq/yannis_puregauge/outputs/l20320b726025x689327a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl20320b726025x689327a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl20320b726025x689327a"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="16:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="wf8_check"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

