cmake_minimum_required(VERSION 4.3.2)

project("interpreter")



function(dec var)
  math(EXPR tmp_var "${${var}} - 1")
  set(${var} ${tmp_var} PARENT_SCOPE)
endfunction()

function(inc var)
  math(EXPR tmp_var "${${var}} + 1")
  set(${var} ${tmp_var} PARENT_SCOPE)
endfunction()

function(malloc size memory_list)
  dec(size)

  string(REPEAT "0;" ${size} tmp_list)
  string(APPEND tmp_list "0")

  set(${memory_list} "${tmp_list}" PARENT_SCOPE)
endfunction()

function(check_closures_ code_name rtn)
  string(LENGTH ${${code_name}} max_index)
  dec(max_index)
  set(layer 0)
  foreach(index RANGE 0 ${max_index})
    string(SUBSTRING ${${code_name}} ${index} 1 el) 
    if("${el}" STREQUAL "[")
      inc(layer)
    elseif("${el}" STREQUAL "]")
      dec(layer)
      if(layer LESS 0)
        set(${rtn} FALSE PARENT_SCOPE)
        return()
      endif()
    endif()
  endforeach()
  if(layer)
    set(${rtn} FALSE PARENT_SCOPE)
    return()
  endif()
  set(${rtn} TRUE PARENT_SCOPE)
endfunction()

function(interpret code_name rtn)
  check_closures_(${code_name} cc_rtn)
  
  if(NOT ${cc_rtn})
    message(SEND_ERROR "Invalid Closures!")
  endif()
  set(${rtn} ${cc_rtn} PARENT_SCOPE)
endfunction()

function(entry)

  set(code "++>-->++++.")
  malloc(200 memory_list)
  interpret(code rtn)

  if(NOT ${rtn})
    message(FATAL_ERROR "Error during interpretation")
  endif()

endfunction()

entry()
