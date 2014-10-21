
function! UnfuckTemplate()
    " replace tabs with spaces
    %s/	/    /g
    " remove whitespace at line ends
    %s/\s\+$//g
    " remove unnecessary whitespaces
    %s/\(\S\)  \(\S\)/\1 \2/gc
    " {{hz}} -> {{ hz }}
    %s/{{\(\S.\{-}\)\s*}}/{{ \1 }}/gc
    %s/{{\s*\(.\{-}\S\)}}/{{ \1 }}/gc
    %s/{{ \(\S.\{-}\)\s{2,}}}/{{ \1 }}/gc
    %s/{{\s{2,}\(.\{-}\S\) }}/{{ \1 }}/gc
    " {%hz%} -> {% hz %}
    %s/{%\(\S.\{-}\)\s*%}/{% \1 %}/gc
    %s/{%\s*\(.\{-}\S\)%}/{% \1 %}/gc
    %s/{% \(\S.\{-}\)\s{2,%}}/{% \1 %}/gc
    %s/{%\s{2,}\(.\{-}\S\) %}/{% \1 %}/gc
    " surround attributes with quotes
    %s/=\([[:alnum:]%]\+\)/="\1"/gc
    " remove spaces before closing triangle bracket
    %s/<\(\w\+\)\s\+>/<\1>/gc
    " add slashes to single tags
    %s/<hr>/<hr \/>/gc
    %s/<br>/<br \/>/gc
    %s/<img \([^>]\+[^\/]\)>/<img \1 \/>/gc
    %s/<input \([^>]\+[^\/]\)>/<input \1 \/>/gc
endfun

command! UnfuckTemplate call UnfuckTemplate()
