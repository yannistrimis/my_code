
#!/bin/bash

cluster=fnal

n_of_lat=500
n_of_sub=1

set_i_lat=101
set_seed=79309

traj_step=1

nx=16
ny=16
nz=16
nt=48

lat_name="l1648b694635x139939a"
out_name="spectuncheck1648b694635x139939"

nmasses=1
mass_arr=( 0.07469      )

nxq=1
xq_arr=( 1.4972      )
xq_name_arr=( 14972      )

u0=1

set_source_start=0
n_sources=2
source_inc=24
source_prec=10

action=hisq
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_tun_new_cw.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1648b694635x139939a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1648b694635x139939a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspectuncheckl1648b694635x139939a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspectuncheckl1648b694635x139939a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
# executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="h15check"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

