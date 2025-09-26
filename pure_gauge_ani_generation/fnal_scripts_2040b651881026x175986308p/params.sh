
#!/bin/bash

cluster=fnal

init_seed=1158
n_of_lat=1000
n_of_sub=8

nx=20
ny=20
nz=20
nt=40

# MILC convention in the improved action is: beta=10/g^2
# Here we use plaquette action and so that is not relevant.
# arxiv 1205.0781 convention is beta=6/g^2

# Now one has to calculate spatial and temporal beta. 

# beta_s=beta/xi_0
# beta_t=beta*xi_0

beta_s=3.70416 #in the MILC colde this appears first
beta_t=11.47221 #and this appears second

beta_name="651881026"
xi_0_name="175986308"

warms=0
trajecs=20
traj_between_meas=1
steps_per_trajectory=4
u0=1.0 # THIS IS !=1 FOR 1-LOOP SYMANZIK
qhb_steps=1

stream="p"

ensemble="2040b651881026x175986308p"
lat_name="l2040b651881026x175986308p"
out_name="out2040b651881026x175986308p"


directory="/lustre2/ahisq/yannis_puregauge/lattices/l2040b651881026x175986308p"
out_dir="/project/ahisq/yannis_puregauge/outputs/l2040b651881026x175986308p"
path_build="/home/trimisio/all/my_code/pure_gauge_ani_generation/build"
run_dir="/project/ahisq/yannis_puregauge/runs/rungenl2040b651881026x175986308p"
submit_dir="/project/ahisq/yannis_puregauge/submits/subgenl2040b651881026x175986308p"

executable="su3_ora_a_dbl_gcc12openmpi4_20250926"

sbatch_time="20:00:00"
sbatch_nodes="5"
sbatch_ntasks="200"
sbatch_jobname="plaq0T"
#sbatch_module1="gcc/12"
#sbatch_module2="openmpi/4"

