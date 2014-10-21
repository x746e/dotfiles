setlocal syntax=conf
"set foldmethod=marker
"set foldmarker={,}

setlocal smartindent

""
" "Compiler" for nginx.conf
setlocal makeprg=nginx\ -t
setlocal errorformat=%m\ in\ %f:%l
