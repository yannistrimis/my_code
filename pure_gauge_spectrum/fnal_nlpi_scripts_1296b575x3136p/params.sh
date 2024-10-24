
#!/bin/bash

cluster=fnal

n_of_lat=400
n_of_sub=1

set_i_lat=101
set_seed=78324

nx=12
ny=12
nz=24
nt=96

lat_name="l1296b575x3136p"
out_name="specnlpi1296b575x3136"

nmasses=1
mass_arr=( 0.10      )

nxq=1
xq_arr=( 2.83      )
xq_name_arr=( 283      )

u0=1

set_source_start=0
n_sources=2
source_inc=48
source_prec=26

err=1e-6
max_cg_iterations=300
action=naive
precision=2

build_script=build_input_nlpi_new.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1296b575x3136p"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1296b575x3136p"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspecnlpil1296b575x3136p"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspecnlpil1296b575x3136p"

# executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20240507"
executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20241022"

sbatch_time="20:00:00"
sbatch_nodes="3"
sbatch_ntasks="96"
sbatch_jobname="nl_nom"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

