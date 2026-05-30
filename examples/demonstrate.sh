#!/bin/bash

cd ../src || exit 1

source_dir="../examples"

function run {
  cmake -G "Ninja Multi-Config" -S ../src -B ../build "$@"
}

# run -Dsource="${source_dir}/hellOwOrld.bf"
# run -Dsource="${source_dir}/char.bf"
run -Dsource="${source_dir}/mv_cell.bf"

cd - || exit 2
