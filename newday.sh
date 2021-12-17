#!/usr/bin/env

if [ "$1" ]; then
    mkdir ${1}
    touch ${1}/data.txt
    touch ${1}/code.jl
else
    echo "missing arg"
fi  