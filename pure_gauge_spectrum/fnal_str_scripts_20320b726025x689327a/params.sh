
#!/bin/bash

cluster=fnal

n_of_lat=200
n_of_sub=5

set_i_lat=101
set_seed=78324

nx=20
ny=20
nz=20
nt=320

lat_name="l20320b726025x689327a"
out_name="specstr20320b726025x689327"

nmasses=4
mass_arr=( 0.05 0.06 0.07 0.08   )

nxq=1
xq_arr=( 7.87      )
xq_name_arr=( 7870      )

u0=1

set_source_start=0
n_sources=2
source_inc=160
source_prec=82

err=1e-6
max_cg_iterations=300
action=hisq
precision=2

build_script=build_input_str.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l20320b726025x689327a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l20320b726025x689327a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspecstrl20320b726025x689327a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspecstrl20320b726025x689327a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20240507"

sbatch_time="20:00:00"
sbatch_nodes="5"
sbatch_ntasks="200"
sbatch_jobname="str_xi8"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

