
#!/bin/bash

cluster=nersc

first_lattice=101

n_of_lat=500
n_of_sub=1

nx=16
ny=16
nz=16
nt=32

lat_name="l1632b7000x182a"
out_name="sflow1632b7000x182a_xf200_dt0.015625"

xi_f=2.0

flow_action="symanzik"
exp_order="16"
dt="0.015625"
stoptime="4.0"


directory="/global/cfs/projectdirs/m1416/yannis_puregauge/lattices/l1632b7000x182a"
out_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/outputs/l1632b7000x182a"
path_build="/global/homes/t/trimisio/my_code/wilson_flow_ani/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/runsflowl1632b7000x182a_xf200_dt0.015625"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/subsflowl1632b7000x182a_xf200_dt0.015625"

executable="region_flow_bbb_a_dbl_crayintel_20251110"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="256"
sbatch_jobname="7w182"

