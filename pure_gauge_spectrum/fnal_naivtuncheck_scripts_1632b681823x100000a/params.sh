
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
nt=32

lat_name="l1632b681823x100000a"
out_name="specnaivtuncheck1632b681823x100000"

nmasses=1
mass_arr=( 0.04273      )

nxq=1
xq_arr=( 1.0      )
xq_name_arr=( 1000      )

u0=1

set_source_start=0
n_sources=2
source_inc=16
source_prec=10

action=naive
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_tun_new_cw.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l1632b681823x100000a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l1632b681823x100000a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspecnaivtuncheckl1632b681823x100000a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspecnaivtuncheckl1632b681823x100000a"

# executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="20:00:00"
sbatch_nodes="2"
sbatch_ntasks="64"
sbatch_jobname="n10check"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

