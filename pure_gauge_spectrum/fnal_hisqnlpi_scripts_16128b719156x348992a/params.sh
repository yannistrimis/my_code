
#!/bin/bash

cluster=fnal

n_of_lat=1000
n_of_sub=2

set_i_lat=1101
set_seed=78324

nx=16
ny=16
nz=16
nt=128

lat_name="l16128b719156x348992a"
out_name="spechisqnlpi16128b719156x348992"

nmasses=1
mass_arr=( 0.01446      )

nxq=1
xq_arr=( 4.0      )
xq_name_arr=( 4000      )

u0=1

set_source_start=0
n_sources=2
source_inc=64
source_prec=30

action=hisq
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_nlpi_new.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l16128b719156x348992a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l16128b719156x348992a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspechisqnlpil16128b719156x348992a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspechisqnlpil16128b719156x348992a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20241118"
# executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20241022"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="hisq4pg"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

