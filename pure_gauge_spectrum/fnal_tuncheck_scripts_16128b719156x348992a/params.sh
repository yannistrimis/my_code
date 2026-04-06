
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
nt=128

lat_name="l16128b719156x348992a"
out_name="spectuncheck16128b719156x348992"

nmasses=1
mass_arr=( 0.072277      )

nxq=1
xq_arr=( 4.0      )
xq_name_arr=( 4000      )

u0=1

set_source_start=0
n_sources=2
source_inc=64
source_prec=34

action=hisq
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_tun_new_cw.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l16128b719156x348992a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l16128b719156x348992a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspectuncheckl16128b719156x348992a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspectuncheckl16128b719156x348992a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
# executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="h40check"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

