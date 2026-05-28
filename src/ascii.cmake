
function(char_to_ascii char out_name)
  string(HEX "${${char}}" hex_val)
  math(EXPR ${out_name} "0x${hex_val}" OUTPUT_FORMAT DECIMAL)
  set(${out_name} ${${out_name}} PARENT_SCOPE)
endfunction()
