#!/bin/bash

cluster=fnal

n_of_lat=1000
n_of_sub=5

set_i_lat=101
set_seed=78324

nx=64
ny=16
nz=16
nt=32

lat_name="l1664b704115x181411zl_rot"
out_name="spechisqtun1664b704115x181411_zdir"

nmasses=5
mass_arr=( 0.0146 0.0073 0.0292 0.0730 0.1022  )

nxq=5
xq_arr=( 1.980 1.60 1.80 2.00 2.20  )
xq_name_arr=( 1980 1600 1800 2000 2200  )

u0=1

set_source_start=0
n_sources=2
source_inc=16
source_prec=10

action=hisq
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_tun_new.sh


directory="/lustre2/ahisq/yannis_puregauge/lattices/l1664b704115x181411zl"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1664b704115x181411zl"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspechisqtunl1664b704115x181411zl_zdir"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspechisqtunl1664b704115x181411zl_zdir"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
# executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="hisqtz"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

