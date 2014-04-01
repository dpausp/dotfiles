" create new jade file
"
fun! <SID>MakeNewJade()
    put = ''
    put = '// generated from jade'
    put = '//- vim: set filetype=jade sw=2 ts=2 sts=2 expandtab:'
endfun


com! -nargs=0 NewJade call <SID>MakeNewJade()

augroup NewJade
    au!
    autocmd BufNewFile *.jade call <SID>MakeNewJade() | set filetype=jade
augroup END
