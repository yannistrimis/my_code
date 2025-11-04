
#!/bin/bash

cluster=fnal

n_of_lat=1000
n_of_sub=4

set_i_lat=101
set_seed=78324

nx=16
ny=16
nz=16
nt=32

lat_name="l1632b687348x115792a"
out_name="spechisqnlpi1632b687348x115792"

nmasses=1
mass_arr=( 0.01521      )

nxq=1
xq_arr=( 1.195      )
xq_name_arr=( 1195      )

u0=1

set_source_start=0
n_sources=2
source_inc=16
source_prec=10

action=hisq
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_nlpi_new.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1632b687348x115792a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1632b687348x115792a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspechisqnlpil1632b687348x115792a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspechisqnlpil1632b687348x115792a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
# executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="12nlpi"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

