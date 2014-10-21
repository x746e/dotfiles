" Ftplugin for bindzone
" Last Change:  2009 Sep 06
" Maintainer:   Kirill Spitsin <tn@0x746e.org.ua>
" License:      This file is placed in the public domain.

" XXX: do we need to save cpo?
" let s:save_cpo = &cpo
" set cpo&vim

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

" TODO:
" * warn if exiting without updating serial number, and offer to
"   update it
" * move :make functionality to compiler plugin? (usr_41.13)
fun! b:GetZoneName()
    let line_num = search('\c[a-zA-Z0-9\.]\+\s\+in\s\+soa')
    let line = getline(line_num)
    return substitute(line,'\s\+.*$','','')
endfunc

fun! b:GetSerialNum()
    let line_num = search(';\s\+serial')
    let line = getline(line_num)
    return substitute(substitute(line,';.\+$','',''),'\s\+','','')
endfunc

fun! b:BufWriteCmd()
    if b:GetSerialNum() == b:old_serial
        echohl WarningMsg
        echomsg "Serial number have not changed. Use w! to write."
        echohl None
    else
        exec "w"
    endif
endfunc

let b:old_serial = b:GetSerialNum()
au BufWriteCmd <buffer> call b:BufWriteCmd()

""
" Compiler for bindzone (named-checkzone)
exec printf('setlocal makeprg=named-checkzone\ %s\ %%', b:GetZoneName())
setlocal errorformat=%f\\:%l:%m,dns_rdata_fromtext:\ %f\\:%l:\ %m

au QuickfixCmdPost make call b:AlterErrorList()
fun! b:AlterErrorList()
    let qflist = getqflist()
    for i in qflist
        if !i.valid
            " i don't now, how make same with 'errorformat'
            let pattern = '\(\w\+\): \(\f\+\):\(\d\+\): \(.\+\)'
            if i.text =~ pattern
                let i.filename = substitute(i.text, pattern, '\2', '')
                let i.lnum = substitute(i.text, pattern, '\3', '')
                let i.text = substitute(i.text, pattern, '\1: \4', '')
                let i.valid = 1
                echo 'aaa'
            endif
        endif
    endfor
    call setqflist(qflist)
endfunc


" TODO:
"
fun! <SID>UpdSerialNumber()
    let old_serial_num = expand('<cword>')

    " check, if it is a valid serial number (32-bit uint)
    let valid = 1
    if (!(old_serial_num =~ '\<\d\+\>'))
        let valid = 0
    elseif len(old_serial_num)>10 " >9999999999>4294967295 --- overflows
            let valid = 0
    elseif len(old_serial_num) == 10
        let n = str2nr(old_serial_num[0:8])
        let m = str2nr(old_serial_num[9])
        if n > 429496729
            let valid = 0
        elseif n == 429496729 && m > 5
            let valid = 0
        endif
    "elseif len(old_serial_num)<10 " <=999999999<4294967295 --- not overflows
    endif
            
    let ymdn_format = 1
    let in_future = 0
    let nn_overflow = 0
    if !(old_serial_num =~ '\<\d\{10}\>')
        let ymdn_format = 0
    else
        let year = str2nr(old_serial_num[0:3])
        let month = str2nr(old_serial_num[4:5])
        let day = str2nr(old_serial_num[6:7])
        let nn = str2nr(old_serial_num[8:9])        
        if month > 12
            let ymdn_format = 0
        elseif day > 31
            let ymdn_format = 0
        endif
        if nn == 99
            let nn_overflow = 1
        endif
    endif

    if nn_overflow || in_future
        " in such case manual user intervention is needed
        echohl ErrorMsg
        if nn_overflow
            echomsg 'nn overflow'
        elseif in_future
            echomsg 'Serial number is for future date'
        endif
        echohl None
        return
    endif

    if !valid || !ymdn_format
        echohl WarningMsg
        if !valid
            echomsg 'Invalid serial number'
        elseif !ymdn_format
            echomsg 'Serial number is not in yyyymmddnn format'
        endif
        let choice = confirm('Replace it with new generated serialnum?', 
                    \ "&Yes\n&No", 1, 'Warning')
        echohl None
        if choice == 2
            return 
        endif
    endif

    let dtime = strftime("%Y%m%d")
    
    if old_serial_num[0:7] ==# dtime " check, if serial_num is for todays date
        let n = str2nr(old_serial_num[8:9])
        let new_serial_num = printf("%s%02d", dtime, n+1)
    else
        let new_serial_num = printf("%s00", dtime)
    endif

    let newline = substitute(getline('.'),old_serial_num,new_serial_num,'')
    call setline('.', newline)
endfun


if !hasmapto('<Plug>UpdSerialNumber')
   map <buffer> <unique> <LocalLeader>u <Plug>UpdSerialNumber
endif
nnoremap <buffer> <unique> <Plug>UpdSerialNumber :call <SID>UpdSerialNumber()<CR>
