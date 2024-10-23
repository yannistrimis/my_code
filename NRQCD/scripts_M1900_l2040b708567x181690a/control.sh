#!/bin/bash

lat=$1

../build/mainprogram <<EOF
"${lat}"
EOF
