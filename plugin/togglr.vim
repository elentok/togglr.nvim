" vim: foldmethod=marker
" Keys {{{1
if !exists('g:togglr_key')
  let g:togglr_key = '<Leader>tw'
endif

exec 'noremap ' . g:togglr_key . ' :call togglr#toggle()<cr>'

" Values {{{1

let g:togglr_values = {
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
      \ "padding-top": "padding-bottom"
      \}

" Functions {{{1

func! togglr#refresh()
  for [key, value] in items(g:togglr_values)
    if !has_key(g:togglr_values, value)
      let g:togglr_values[value] = key
    end
  endfor
endfunc

call togglr#refresh()

func! togglr#toggle()
  let value = expand("<cword>")
  if has_key(g:togglr_values, value)
    let other_value = g:togglr_values[value]
    exec "normal ciw" . other_value
  end
endfunc

func! togglr#add(value1, value2)
  let g:togglr_values[a:value1] = a:value2
  let g:togglr_values[a:value2] = a:value1
endfunc

