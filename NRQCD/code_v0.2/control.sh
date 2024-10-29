#!/bin/bash

lat=$1

./mainprogram <<EOF
"${lat}"
EOF
