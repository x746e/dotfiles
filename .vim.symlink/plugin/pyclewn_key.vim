function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! s:print_visial_selection()
    let expression = s:get_visual_selection()
    exe "Cpp " . expression
endfunction


function! MapClewnKeys()
    map <Space> :Cnext<CR>
    map s       :Cstep<CR>
    nmap p      :exe "Cpp " . expand("<cword>") <CR>
    vmap p      :call <SID>print_visial_selection()<CR>
    map U       :Cup<CR>
    map D       :Cdown<CR>
    map r       :Creturn<CR>
    map M-b     :exe "Cbreak " . expand("%:p") . ":" . line(".") <CR>
    map M-e     :exe "Cclear " . expand("%:p") . ":" . line(".") <CR>
endfunction

"call MapClewnKeys()
command! MapClewnKeys call MapClewnKeys()
