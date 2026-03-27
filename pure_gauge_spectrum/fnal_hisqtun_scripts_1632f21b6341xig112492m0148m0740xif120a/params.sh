
#!/bin/bash

cluster=fnal

n_of_lat=1
n_of_sub=1

set_i_lat=105
set_seed=78324

traj_step=5

nx=16
ny=16
nz=16
nt=32

lat_name="l1632f21b6341xig112492m0148m0740xif120a"
out_name="spechisqtun1632f21b6341xig112492m0148m0740xif120"

nmasses=1
mass_arr=( 0.074      )

nxq=1
xq_arr=( 1.2      )
xq_name_arr=( 120      )

u0=1

set_source_start=0
n_sources=2
source_inc=16
source_prec=10

action=hisq
err=1e-6
max_cg_iterations=300
precision=2

build_script=build_input_tun_new.sh


directory="/lustre2/ahisq/yannis_dyn/lattices/l1632f21b6341xig112492m0148m0740xif120a"
out_dir="/project/ahisq/yannis_dyn/outputs/spec/l1632f21b6341xig112492m0148m0740xif120a"
path_build="/home/trimisio/all/my_code/pure_gauge_spectrum/build"
run_dir="/project/ahisq/yannis_dyn/runs/runspechisqtunl1632f21b6341xig112492m0148m0740xif120a"
submit_dir="/project/ahisq/yannis_dyn/submits/subspechisqtunl1632f21b6341xig112492m0148m0740xif120a"

executable="ks_spectrum_ani_hisq_dbl_gcc12openmpi4_20250423"
# executable="ks_spectrum_ani_naive_dbl_gcc12openmpi4_20250423"

sbatch_time="01:00:00"
sbatch_nodes="1"
sbatch_ntasks="32"
sbatch_jobname="specdyn"
sbatch_module1="gcc/12"
sbatch_module2="openmpi/4"

