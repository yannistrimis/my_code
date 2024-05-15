
#!/bin/bash

cluster=fnal

n_of_lat=5
n_of_sub=1

set_i_lat=101
set_seed=78324

nx=16
ny=16
nz=16
nt=128

lat_name="l16128b719156x348992a"
out_name="spectun16128b719156x348992"

nmasses=1
mass_arr=( 0.05      )

nxq=3
xq_arr=( 3.76 3.88 4.00    )
xq_name_arr=( 3760 3880 4000    )

u0=1

set_source_start=0
n_sources=2
source_inc=64
source_prec=34

err=1e-6
max_cg_iterations=300
action=hisq
precision=2

build_script=build_input_tun.sh


directory="/lustre1/ahisq/yannis_puregauge/lattices/l16128b719156x348992a"
out_dir="/project/ahisq/yannis_puregauge/outputs/pure_gauge_spec/l16128b719156x348992a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_puregauge/runs/runspectunl16128b719156x348992a"
submit_dir="/project/ahisq/yannis_puregauge/submits/subspectunl16128b719156x348992a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20240507"

sbatch_time="02:00:00"
sbatch_nodes="4"
sbatch_ntasks="128"
sbatch_jobname="tun_xi4"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

