
#!/bin/bash

cluster=icer

n_of_lat=1000
n_of_sub=1

set_i_lat=404
set_seed=78324

nx=20
ny=20
nz=20
nt=320

lat_name="l20320b726025x689327a"
out_name="spechisqnlpi20320b726025x689327"

nmasses=1
mass_arr=( 0.01416      )

nxq=1
xq_arr=( 7.870      )
xq_name_arr=( 7870      )

u0=1

set_source_start=0
n_sources=2
source_inc=160
source_prec=70

action=hisq
err=1e-6
max_cg_iterations=300
precision=2

# build_script=build_input_nlpi_new.sh
build_script=build_input_nlpi.sh

directory="/mnt/scratch/trimisio/lattices/l20320b726025x689327a"
out_dir="/mnt/home/trimisio/outputs/pure_gauge_spec/l20320b726025x689327a"
path_build="/mnt/home/trimisio/my_code/pure_gauge_spectrum/build"
run_dir="/mnt/scratch/trimisio/runs/runspechisqnlpil20320b726025x689327a"
submit_dir="/mnt/home/trimisio/submits/subspechisqnlpil20320b726025x689327a"

executable="ks_spectrum_ani_hisq_dbl_GCC12OpenMPI4_20250417"

sbatch_time="20:00:00"
sbatch_nodes="5"
sbatch_ntasks_per_node="NA"
sbatch_ntasks="200"
sbatch_jobname="8nlpi"
sbatch_module1="GCC/12"
sbatch_module2="OpenMPI/4"

