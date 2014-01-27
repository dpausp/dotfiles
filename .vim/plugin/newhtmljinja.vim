" create new html+jinja file
"
fun! <SID>MakeNewHTMLJinja()
    put = ''
    put = '{# vim: set filetype=htmljinja sw=4 ts=4 sts=4 expandtab: #}'
    0
endfun


com! -nargs=0 NewHTMLJinja call <SID>MakeNewHTMLJinja()

augroup NewHTMLJinja
    au!
    autocmd BufNewFile *.j2.html call <SID>MakeNewHTMLJinja() | set filetype=htmljinja
augroup END
