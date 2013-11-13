" create new yml file
"
fun! <SID>MakeNewYML()
    put = ''
    put = '# vim: set filetype=yaml sw=2 ts=2 sts=2 expandtab:'
    0 put = '---'
endfun


com! -nargs=0 NewYML call <SID>MakeNewYML()

augroup NewYML
    au!
    autocmd BufNewFile *.yml call <SID>MakeNewYML() | set filetype=yml
augroup END
