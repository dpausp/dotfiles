fu! SaveSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'mksession! ' . getcwd() . '/.session.vim'
endif
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction
autocmd VimLeave * NERDTreeClose
autocmd VimLeave * call SaveSess()

