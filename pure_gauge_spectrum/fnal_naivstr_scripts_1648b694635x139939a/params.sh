
#!/bin/bash

cluster=fnal

n_of_lat=300
n_of_sub=2

set_i_lat=101
set_seed=78324

nx=16
ny=16
nz=16
nt=48

lat_name="l1648b694635x139939a"
out_name="specnaivstr1648b694635x139939"

nmasses=4
mass_arr=( 0.03 0.05 0.07 0.09   )

nxq=1
xq_arr=( 1.00      )
xq_name_arr=( 1000      )

u0=1

set_source_start=0
n_sources=2
source_inc=24
source_prec=10

action=naive
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_tun_new.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1648b694635x139939a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1648b694635x139939a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspecnaivstrl1648b694635x139939a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspecnaivstrl1648b694635x139939a"

# executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20241118"
executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20241022"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="naivstr"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

