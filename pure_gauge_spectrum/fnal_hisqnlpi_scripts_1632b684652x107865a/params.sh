
#!/bin/bash

cluster=fnal

n_of_lat=1000
n_of_sub=2

set_i_lat=101
set_seed=78324

nx=16
ny=16
nz=16
nt=32

lat_name="l1632b684652x107865a"
out_name="spechisqnlpi1632b684652x107865"

nmasses=1
mass_arr=( 0.01497      )

nxq=1
xq_arr=( 1.08      )
xq_name_arr=( 1080      )

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


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1632b684652x107865a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1632b684652x107865a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspechisqnlpil1632b684652x107865a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspechisqnlpil1632b684652x107865a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
# executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="11nlpi"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

