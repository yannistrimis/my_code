
#!/bin/bash

cluster=icer

n_of_lat=200
n_of_sub=5

set_i_lat=101
set_seed=78324

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b704115x181411a"
out_name="specnlpi1664b704115x181411"

nmasses=1
mass_arr=( 0.0146      )

nxq=1
xq_arr=( 1.980      )
xq_name_arr=( 1980      )

u0=1

set_source_start=0
n_sources=2
source_inc=32
source_prec=18

err=1e-6
max_cg_iterations=300
action=hisq
precision=2

build_script=build_input_nlpi.sh


directory="/mnt/scratch/trimisio/lattices/l1664b704115x181411a"
out_dir="/mnt/home/trimisio/outputs/pure_gauge_spec/l1664b704115x181411a"
path_build="/mnt/home/trimisio/my_code/pure_gauge_spectrum/build"
run_dir="/mnt/scratch/trimisio/runs/runspecnlpil1664b704115x181411a"
submit_dir="/mnt/home/trimisio/submits/subspecnlpil1664b704115x181411a"

executable="ks_spectrum_ani_hisq_icc_dbl_20230619"

sbatch_time="16:00:00"
sbatch_ntasks="128"
sbatch_jobname="nlpi_xi2"
sbatch_module="intel/2020b"

