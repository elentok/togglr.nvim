" vim: foldmethod=marker

if has('nvim')
  finish
end

" Settings {{{1
if !exists('g:togglr_key')
  let g:togglr_key = '<Leader>tw'
endif

if !exists('g:togglr_register')
  let g:togglr_register = 't'
endif

" Values {{{1

let s:togglr_values = {
      \ "true": "false",
      \ "True": "False",
      \ "yes": "no",
      \ "on": "off",
      \ "enabled": "disabled",
      \ "enable": "disable",
      \ "left": "right",
      \ "top": "bottom",
      \ "should": "should_not",
      \ "be_true": "be_false",
      \ "border-left": "border-right",
      \ "border-top": "border-bottom",
      \ "margin-left": "margin-right",
      \ "margin-top": "margin-bottom",
      \ "padding-left": "padding-right",
      \ "padding-top": "padding-bottom",
      \ "addClass": "removeClass"
      \}

" add the reverse mappings to the hash
for [key, value] in items(s:togglr_values)
  if !has_key(s:togglr_values, value)
    let s:togglr_values[value] = key
  end
endfor

" Functions {{{1

func! togglr#add(value1, value2)
  let s:togglr_values[a:value1] = a:value2
  let s:togglr_values[a:value2] = a:value1
endfunc

func! togglr#toggle()
  let value = expand("<cword>")
  if has_key(s:togglr_values, value)
    let other_value = s:togglr_values[value]
    exec "normal! \"" . g:togglr_register . "ciw" . other_value
  end
endfunc

exec 'noremap ' . g:togglr_key . ' :call togglr#toggle()<cr>'
