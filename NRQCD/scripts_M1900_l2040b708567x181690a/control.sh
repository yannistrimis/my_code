#!/bin/bash

lat=$1

../build/mainprogram_v02 <<EOF
"${lat}"
EOF
