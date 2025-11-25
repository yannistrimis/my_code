
#!/bin/bash

cluster=nersc

first_lattice=101

n_of_lat=500
n_of_sub=4

nx=20
ny=20
nz=20
nt=160

lat_name="l20160b7433x68500a"
out_name="zflow20160b7433x68500a_xf800_dt0.0078125"

xi_f=8.0

flow_action="zeuthen"
exp_order="16"
dt="0.0078125"
stoptime="5.0"


directory="/global/cfs/projectdirs/m1416/yannis_puregauge/lattices/l20160b7433x68500a"
out_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/outputs/l20160b7433x68500a"
path_build="/global/homes/t/trimisio/my_code/wilson_flow_ani/build"
run_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/runs/runzflowl20160b7433x68500a_xf800_dt0.0078125"
submit_dir="/global/cfs/projectdirs/m1416/yannis_puregauge/submits/subzflowl20160b7433x68500a_xf800_dt0.0078125"

executable="region_flow_bbb_a_dbl_crayintel_20251110"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="256"
sbatch_jobname="zf68500"

