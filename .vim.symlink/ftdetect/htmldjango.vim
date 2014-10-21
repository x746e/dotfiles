au BufNewFile,BufRead *.html        call s:check_djangohtml()

func! s:check_djangohtml()
    if match(expand("<afile>:p"), "/templates/") != -1
        set filetype=htmldjango
    endif
endfunc
