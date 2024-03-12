
#!/bin/bash

cluster=fnal

first_lattice=1

n_of_lat=4
n_of_sub=1

nx=16
ny=16
nz=16
nt=32

lat_name="l1632b6850x100d"
out_name="wflow1632b6850x100xf100d_dt0.015625"

xi_f=1.00

flow_action="wilson"
exp_order="16"
dt="0.015625"
stoptime="3.5"


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1632b6850x100d"
out_dir="/project/ahisq/yannis_puregauge/outputs/l1632b6850x100d"
path_build="/home/trimisio/all/my_code/wilson_flow_ani/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runwflowl1632b6850x100d"
submit_dir="/project/ahisq/yannis_puregauge/submits/subwflowl1632b6850x100d"

executable="region_flow_bbb_a_dbl_gcc12openmpi4_20240212"

sbatch_time="8:00:00"
sbatch_nodes="2"
sbatch_ntasks="16"
sbatch_jobname="sc16"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

