#!/bin/bash

cd ../src || exit 1

source_dir="../examples"

function run {
  cmake -G "Ninja Multi-Config" -S ../src -B ../build "$@"
}

run -Dsource="${source_dir}/hellOwOrld.bf"
run -Dsource="${source_dir}/char.bf"
run -Dsource="${source_dir}/mv_cell.bf" -Ddebug=ON -Dinput="a"
# run -Dsource="../examples/triangle.bf" -Ddebug=ON -Dcode_view=OFF -Dsize=1024 # On my PC, this took 136 seconds :O
# run -Dsource="../examples/mandelbrot.bf" -Ddebug=ON -Dcode_view=OFF -Dsize=1024 # Don't even try X_X

cd - || exit 2
