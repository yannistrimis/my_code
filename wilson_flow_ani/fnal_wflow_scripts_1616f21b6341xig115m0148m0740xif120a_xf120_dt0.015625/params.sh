
#!/bin/bash

cluster=fnal

first_lattice=5
traj_step=5

n_of_lat=600
n_of_sub=1

nx=16
ny=16
nz=16
nt=16

lat_name="l1616f21b6341xig115m0148m0740xif120a"
out_name="wflow1616f21b6341xig115m0148m0740xif120a_xf120_dt0.015625"

xi_f=1.2

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="6.0"


directory="/lustre2/ahisq/yannis_dyn/lattices/l1616f21b6341xig115m0148m0740xif120a"
out_dir="/project/ahisq/yannis_dyn/outputs/l1616f21b6341xig115m0148m0740xif120a"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_dyn/runs/runwflowl1616f21b6341xig115m0148m0740xif120a_xf120"
submit_dir="/project/ahisq/yannis_dyn/submits/subwflowl1616f21b6341xig115m0148m0740xif120a_xf120"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="wf11512"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

