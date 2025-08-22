
#!/bin/bash

cluster=fnal

n_of_lat=500
n_of_sub=5

set_i_lat=101
set_seed=78324

nx=16
ny=16
nz=16
nt=64

lat_name="l1664b704115x181411a"
out_name="specnaivtun1664b704115x181411"

nmasses=3
mass_arr=( 0.025 0.035 0.045    )

nxq=3
xq_arr=( 1.2 1.6 2.0    )
xq_name_arr=( 120 160 200    )

u0=1

set_source_start=0
n_sources=2
source_inc=32
source_prec=20

action=naive
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_tun_new.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1664b704115x181411a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1664b704115x181411a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspecnaivtunl1664b704115x181411a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspecnaivtunl1664b704115x181411a"

# executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="20naivun"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

