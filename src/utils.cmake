# BASE

#  var
function(dec var)
  math(EXPR tmp_var "${${var}} - 1")
  set(${var} ${tmp_var} PARENT_SCOPE)
endfunction()

function(inc var)
  math(EXPR tmp_var "${${var}} + 1")
  set(${var} ${tmp_var} PARENT_SCOPE)
endfunction()

#  list
function(list_set_at list_name index value)
  list(INSERT ${list_name} ${index} "${value}")
  inc(index)
  list(REMOVE_AT ${list_name} ${index})
  set(${list_name} "${${list_name}}" PARENT_SCOPE)
endfunction()

#  string
function(string_insert_at src_string_name index string_to_insert)
  string(LENGTH "${${src_string_name}}" src_string_len)
  if(${src_string_len} LESS_EQUAL ${index})
    string(APPEND ${src_string_name} "${string_to_insert}")
    set(${src_string_name} "${${src_string_name}}" PARENT_SCOPE)
    return()
  elseif(${index} EQUAL 0)
    string(PREPEND ${src_string_name} "${string_to_insert}")
    set(${src_string_name} "${${src_string_name}}" PARENT_SCOPE)
    return()
  endif()
  string(SUBSTRING "${${src_string_name}}" 0 ${index} string_left)
  math(EXPR piece_size "${src_string_len} - ${index}")
  string(SUBSTRING "${${src_string_name}}" ${index} ${piece_size} string_right)
  string(APPEND string_left "${string_to_insert}")
  string(APPEND string_left "${string_right}")
  set(${src_string_name} "${string_left}" PARENT_SCOPE)
endfunction()

# MEM

function(malloc size memory_list)
  dec(size)

  string(REPEAT "0;" ${size} tmp_list)
  string(APPEND tmp_list "0")

  set(${memory_list} "${tmp_list}" PARENT_SCOPE)
endfunction()

# STACK

function(stack_push stack_name value)
  list(APPEND ${stack_name} "${value}")
  set(${stack_name} "${${stack_name}}" PARENT_SCOPE)
endfunction()

function(stack_pop stack_name)
  list(LENGTH ${stack_name} stack_len)
  if(stack_len EQUAL 0)
    message(FATAL_ERROR "Stack underflow")
  endif()

  list(POP_BACK ${stack_name} top)
  set(${stack_name} "${${stack_name}}" PARENT_SCOPE)

  if(${ARGC} GREATER 1)
    set(${ARGV1} ${top} PARENT_SCOPE)
  endif()
endfunction()

function(stack_top stack_name out_name)
  list(LENGTH ${stack_name} stack_len)
  if(stack_len EQUAL 0)
    message(FATAL_ERROR "Stack is empty")
  endif()

  list(GET ${stack_name} -1 top)
  set(${out_name} ${top} PARENT_SCOPE) 
endfunction()
