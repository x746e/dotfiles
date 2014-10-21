
set background=dark
hi User1 term=inverse,bold  cterm=inverse,bold ctermfg=Red
hi User2 term=bold          cterm=bold         ctermfg=Yellow
hi User3 term=inverse,bold  cterm=inverse,bold ctermfg=Blue
hi User4 term=inverse,bold  cterm=inverse,bold ctermfg=LightBlue
hi User5 term=inverse,bold  cterm=inverse,bold ctermfg=Red ctermbg=Green
hi User1 gui=bold guifg=White     guibg=Red
hi User2 gui=bold guifg=Yellow    guibg=Black
hi User3 gui=bold guifg=Blue      guibg=White
hi User4 gui=bold guifg=LightBlue guibg=White
hi User5 gui=bold guifg=Green     guibg=Red
hi Folded     term=standout cterm=bold ctermfg=4        ctermbg=Black
hi FoldColumn term=standout            ctermfg=DarkBlue ctermbg=Black
hi Folded     gui=bold guibg=Black guifg=Blue
hi FoldColumn          guibg=Black guifg=Blue

" Colors like MS VC++ and better :)                 (c) Alexander Kulinich <rulez@rulez.kiev.ua>
hi Constant     term=NONE   cterm=NONE ctermfg=DarkCyan     ctermbg=black guibg=black guifg=DarkCyan
hi String       term=NONE   cterm=NONE ctermfg=DarkRed      ctermbg=black guibg=black guifg=DarkRed
hi Character    term=NONE   cterm=NONE ctermfg=DarkRed      ctermbg=black guibg=black guifg=DarkRed
"hi Number       term=NONE   cterm=NONE ctermfg=DarkCyan     ctermbg=black guibg=black guifg=gray
"hi Boolean      term=NONE   cterm=NONE ctermfg=DarkCyan     ctermbg=black guibg=black guifg=gray
"hi Float        term=NONE   cterm=NONE ctermfg=DarkCyan     ctermbg=black guibg=black guifg=gray
hi Comment      term=NONE   cterm=NONE ctermfg=Darkgreen    ctermbg=black guibg=black guifg=Darkgreen
hi Identifier   term=NONE   cterm=NONE ctermfg=DarkCyan     ctermbg=black guibg=black guifg=DarkCyan
hi PreProc      term=NONE   cterm=NONE ctermfg=DarkCyan   ctermbg=black guibg=black guifg=DarkRed
"hi Type         term=NONE   cterm=NONE ctermfg=Blue         ctermbg=black guibg=black guifg=gray
"hi Special      term=NONE   cterm=NONE ctermfg=Red          ctermbg=black guibg=black guifg=Red
"hi Keyword      term=NONE   cterm=NONE ctermfg=Red          ctermbg=black guibg=black guifg=gray
hi Statement    term=NONE   cterm=NONE ctermfg=Yellow    ctermbg=black guibg=black guifg=LightBlue

"syn region      stdType     start="^\s*std::\s*" end="\ "
"syn match   stdType     "std::"
"syn match stdType               "\<std\:\:\(string\|static\|dynamic\|reinterpret\)\s*<"me=e-1
"syn match stdType               "\<std\:\:\(string\|static\|dynamic\|reinterpret\)\s*$"
"hi stdType  term=NONE   cterm=NONE ctermfg=LightBlue    ctermbg=black guibg=black guifg=gray


" Green cursor it`s cool :)
 hi Cursor   guibg=Green guifg=NONE
" LineNr:  Colorize the line numbers (displayed with "set number").
hi LineNr   term=NONE cterm=NONE
" coloring "nontext", ie TABs, trailing spaces,  end-of-lines,
" and the "tilde lines" representing lines after end-of-buffer.
hi NonText      term=NONE cterm=NONE ctermfg=blue   ctermbg=black
" Normal text:    Use white on black.
hi normal ctermfg=grey  ctermbg=black   guifg=grey  guibg=black
" Search: Coloring "search matches".  Use black on yellow.
hi search  ctermfg=black ctermbg=yellow     guifg=black guibg=yellow
" statusline:  coloring the status line
hi StatusLine   term=NONE cterm=NONE ctermfg=white  ctermbg=blue
hi StatusLineNC term=NONE cterm=NONE ctermfg=black  ctermbg=white
