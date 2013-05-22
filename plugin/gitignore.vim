
function! s:parse(filename)
    let igstring = ''
    if filereadable(a:filename)
        for oline in readfile(a:filename)
            let line = substitute(oline, '\s|\n|\r', '', "g")
            if line =~ '^#' | con | endif
            if line == '' | con  | endif
            if line =~ '^!' | con  | endif
            if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
            let igstring .= "," . line
        endfor
    endif
    return substitute(igstring, '^,', '', "g")
endfunction

function! s:globalconfig()
    " TODO parse the .gitignore from $(git config --global core.excludesfile)
    return ''
endfunction

function! s:localconfigs()
    let fname = '.gitignore'
    let configs = ''
    for i in range(0, 5)
        let configs .= s:parse(fname)
        let fname = '../'.fname
    endfor
    return configs
endfunction

exec 'set wildignore='.s:globalconfig().s:localconfigs()
