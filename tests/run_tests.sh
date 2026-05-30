#!/bin/bash

INTERPRETER_PREFIX_PATH="../src/"
BUILD_DIR="../build"

function run_interpreter {
  cmake -G "Ninja Multi-Config" -S "$INTERPRETER_PREFIX_PATH" -B "$BUILD_DIR" "$@"
}

function test_default_behavior {
  run_interpreter
}

function test_input_overflow {
  run_interpreter -Dcode=",," -Dinput="A"
}

function test_correct_input {
  run_interpreter -Dcode=",.,." -Dinput="OK"
}

function test_static_memory_view {
  run_interpreter -Dcode="+++>++>+" -Dsize=10 -Dmemory_view=5
}

function test_memory_view_off {
  run_interpreter -Dcode="+++++" -Dmemory_view=OFF
}

function test_debug_breakpoint {
  run_interpreter -Dcode="+++B++" -Ddebug=ON
}

function test_debug_drop {
  run_interpreter -Dcode="+++B.----" -Ddebug="drop"
}

function test_cell_trace {
  run_interpreter -Dcode="+>+>+>+>+>+" -Ddebug=ON
}

function test_cell_trace_with_static_mem { # |0|0|> 0 <;0| # BRUH!
  run_interpreter -Dcode="><><>B>" -Dmemory_view=4 -Dcell_trace=ON
}

all_tests=$(declare -F | awk '{print $3}' | grep "^test_")

for test_func in $all_tests; do
  echo "Running: $test_func"
  $test_func
  echo "----------------------------------------"
done
