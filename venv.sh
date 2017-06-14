#!/bin/bash
# source this file from the shell
# source ./venv.sh
dir=`pwd`
source ./venv/bin/activate
echo "source ./venv/bin/activate"
export PYTHONPATH=".:$dir/build/code"
echo "export PYTHONPATH=$PYTHONPATH"
