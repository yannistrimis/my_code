
#!/bin/bash

cluster=fnal

n_of_lat=400
n_of_sub=1

set_i_lat=201
set_seed=78324

nx=16
ny=16
nz=16
nt=32

lat_name="l1632f2b5425m0375xig15xiq15a"
out_name="specnaivnlpi1632f2b5425m0375xig15xiq15"

nmasses=1
mass_arr=( 0.0375      )

nxq=1
xq_arr=( 1.5      )
xq_name_arr=( 15      )

u0=1

set_source_start=0
n_sources=2
source_inc=16
source_prec=10

action=naive
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_nlpi_new.sh


directory="/lustre1/ahisq/yannis_dyn/lattices/l1632f2b5425m0375xig15xiq15a"
out_dir="/project/ahisq/yannis_dyn/outputs/spec/l1632f2b5425m0375xig15xiq15a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_dyn/runs/runspecnaivnlpil1632f2b5425m0375xig15xiq15a"
submit_dir="/project/ahisq/yannis_dyn/submits/subspecnaivnlpil1632f2b5425m0375xig15xiq15a"

# executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="20:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="comp"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

