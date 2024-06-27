
#!/bin/bash

cluster=fnal

n_of_lat=100
n_of_sub=4

set_i_lat=101
set_seed=78324

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b704115x181411z"
out_name="spectun1664b704115x181411"

nmasses=1
mass_arr=(   0.07    )

nxq=3
xq_arr=( 1.84 1.92 2.00    )
xq_name_arr=( 1840 1920 2000    )

u0=1

set_source_start=0
n_sources=2
source_inc=32
source_prec=18

err=1e-6
max_cg_iterations=300
action=hisq
precision=2

build_script=build_input_tun.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b704115x181411z"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1664b704115x181411z"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspectunl1664b704115x181411z"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspectunl1664b704115x181411z"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20240507"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="tunz"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

