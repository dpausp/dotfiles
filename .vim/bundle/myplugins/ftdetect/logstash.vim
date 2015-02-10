fun! s:DetectLogstash()
    if getline(1) =~ '^[ \t]*\(input\|output\|filter\) {'
        set ft=logstash
    endif
endfun

autocmd BufNewFile,BufRead *.conf call s:DetectLogstash()
