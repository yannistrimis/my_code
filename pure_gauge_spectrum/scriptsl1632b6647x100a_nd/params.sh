#!/bin/bash

n_of_lat=20

nx=16
ny=16
nz=16
nt=32

set_i_lat=101
set_seed=5204

beta_name="6647"
xi_0_name="100"
xq_0_name="100"
stream="a"
lat_name="l${nx}${nt}b${beta_name}x${xi_0_name}${stream}"

path_build="/mnt/home/trimisio/comm_code/pure_gauge_spectrum/build"
directory="/mnt/home/trimisio/outputs/pure_gauge_spec/${lat_name}"
lat_directory="/mnt/home/bazavov/scratch/puregauge/lattices/${lat_name}"
run_dir="/mnt/home/trimisio/scratch/runs/runspecnd${lat_name}"
submit_dir="/mnt/home/trimisio/submits/subspecnd${lat_name}"

u0=1

set_source_start=0
n_sources=2
source_inc=16
source_prec=7 # CHANGE ACCORDING TO nt

nmasses=2
mass1=0.01986
mass2=0.0993

mass1_name="01986"
mass2_name="0993"

err=1e-6
max_cg_iterations=300
action=hisq
precision=2

