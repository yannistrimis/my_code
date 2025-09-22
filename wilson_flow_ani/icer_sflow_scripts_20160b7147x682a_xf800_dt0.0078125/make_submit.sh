#!/bin/bash

source ${1}/params.sh

if [ ${cluster} == "icer" ]
then

cat <<EOF > ${submit_dir}/submit_script.sb
#!/bin/bash --login

#SBATCH --time=${sbatch_time}
##SBATCH --nodes=${sbatch_nodes}
#SBATCH --ntasks=${sbatch_ntasks}
#SBATCH --constraint=intel18
#SBATCH --job-name=${sbatch_jobname}

module purge
module load GCC/12
module load OpenMPI/4

bash ${1}/control_script.sh ${1}

EOF

elif [ ${cluster} == "fnal" ]
then

cat <<EOF > ${submit_dir}/submit_script.sb
#!/bin/bash

#SBATCH --time=${sbatch_time}
#SBATCH --partition=lq1_cpu
#SBATCH --nodes=${sbatch_nodes}
#SBATCH --ntasks=${sbatch_ntasks}
#SBATCH -A ahisq.lq1_cpu
#SBATCH --qos=normal

#SBATCH --job-name=${sbatch_jobname}

module purge
module load gcc/12
module load openmpi/4

bash ${1}/control_script.sh ${1}

EOF

elif [ ${cluster} == "nersc" ]
then

cat <<EOF > ${submit_dir}/submit_script.sb
#!/bin/bash

#SBATCH -A m1416
#SBATCH --qos=regular
#SBATCH --time=${sbatch_time}
#SBATCH --nodes=${sbatch_nodes}
#SBATCH --ntasks=${sbatch_ntasks}
#SBATCH --constraint=cpu
#SBATCH --job-name=${sbatch_jobname}

bash ${1}/control_script.sh ${1}

EOF


fi
 
