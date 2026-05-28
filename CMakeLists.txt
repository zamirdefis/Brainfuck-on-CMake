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

function(check_closures_ tokens_name rtn)
  set(layer 0)
  foreach(el ${${tokens_name}})
message("${el}")
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

function(interpret tokens_name rtn)
  check_closures_(${tokens_name} rtn)
  
  if(NOT rtn)
    message(WARNING "Invalid Closures!")
    set(${rtn} FALSE PARENT_SCOPE)
    return()
  endif()
  set(${rtn} TRUE PARENT_SCOPE)
endfunction()

function(entry)
  set(string_code "++>-->++++.")
  string(REGEX REPLACE "(.)" "\\1;" tokens "${string_code}")

  list(LENGTH tokens list_len)
message("${list_len}")
  
  malloc(200 memory_list)



  interpret(tokens rtn)
  if(NOT rtn)
    message(FATAL_ERROR "Error during interpretation")
  endif()
endfunction()

entry()
