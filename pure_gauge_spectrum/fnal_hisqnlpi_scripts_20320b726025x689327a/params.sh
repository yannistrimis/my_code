#!/bin/bash

cluster=fnal

n_of_lat=1000
n_of_sub=2

set_i_lat=101
set_seed=79309

nx=20
ny=20
nz=20
nt=320

lat_name="l20320b726025x689327a"
out_name="spechisqnlpi_str20320b726025x689327"

nmasses=1
mass_arr=( 0.0708      )

nxq=1
xq_arr=( 7.87      )
xq_name_arr=( 7870      )

u0=1

set_source_start=0
n_sources=2
source_inc=160
source_prec=90

action=hisq
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_nlpi_new.sh


directory="/lustre2/ahisq/yannis_puregauge/lattices/l20320b726025x689327a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l20320b726025x689327a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspechisqnlpi_strl20320b726025x689327a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspechisqnlpi_strl20320b726025x689327a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
# executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="hisq8str"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

