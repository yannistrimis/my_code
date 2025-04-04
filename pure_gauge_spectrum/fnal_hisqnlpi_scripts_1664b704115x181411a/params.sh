
#!/bin/bash

cluster=fnal

n_of_lat=1000
n_of_sub=1

set_i_lat=1101
set_seed=78324

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b704115x181411a"
out_name="spechisqnlpi1664b704115x181411"

nmasses=1
mass_arr=( 0.0146      )

nxq=1
xq_arr=( 1.98      )
xq_name_arr=( 1980      )

u0=1

set_source_start=0
n_sources=2
source_inc=32
source_prec=30

action=hisq
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_nlpi_new.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b704115x181411a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1664b704115x181411a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspechisqnlpil1664b704115x181411a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspechisqnlpil1664b704115x181411a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20241118"
# executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20241022"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="hisq2pg"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

