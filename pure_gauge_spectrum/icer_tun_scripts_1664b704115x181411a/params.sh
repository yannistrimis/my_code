
#!/bin/bash

cluster=icer

n_of_lat=5
n_of_sub=1

set_i_lat=101
set_seed=78324

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b704115x181411a"
out_name="spectun1664b704115x181411"

nmasses=1
mass_arr=( 0.06      )

nxq=3
xq_arr=( 1.88 1.94 2.00    )
xq_name_arr=( 1880 1940 2000    )

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


directory="/mnt/scratch/trimisio/lattices/l1664b704115x181411a"
out_dir="/mnt/home/trimisio/outputs/pure_gauge_spec/l1664b704115x181411a"
path_build="/mnt/home/trimisio/my_code/pure_gauge_spectrum/build"
run_dir="/mnt/scratch/trimisio/runs/runspectunl1664b704115x181411a"
submit_dir="/mnt/home/trimisio/submits/subspectunl1664b704115x181411a"

executable="ks_spectrum_ani_hisq_icc_dbl_20230619"

sbatch_time="02:00:00"
sbatch_ntasks="128"
sbatch_jobname="tun_xi2"
sbatch_module="intel/2020b"

