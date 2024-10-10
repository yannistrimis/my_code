#!/bin/bash

lat_name=$1
lat_dir=$2
i_file=$3

./mainprogram <<EOF
"${lat_dir}/${lat_name}.trunc.${i_file}"
EOF
