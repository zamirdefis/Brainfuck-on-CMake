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
