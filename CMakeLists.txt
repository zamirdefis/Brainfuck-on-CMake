cmake_minimum_required(VERSION 4.3.2)

project("interpreter")

set(var "test")

function(test_func a b)
  message("argc : ${ARGC}")
  message("argv : ${ARGV}")
  message("argn : ${ARGN}")

  message("argv1 : ${ARGV1}")
  message("argn1 : ${ARGN1}")
endfunction()

test_func(1;2;3;4)
