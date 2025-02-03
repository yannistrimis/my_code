#!/bin/bash

lat=$1
corr=$2

./mainprogram_v0.3 <<EOF
"${lat}"
"${corr}.corr1s0"
"${corr}.corr3s1"
EOF
