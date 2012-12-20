call pathogen#infect()
inoremap <Nul> <C-x><C-n>

set incsearch
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set smartindent
set showmatch
set smartcase
set showmode
set nu
set ruler
set softtabstop=4
set backspace=indent,eol,start
set encoding=utf8
set wildmenu
set wildignore=*.pyc,*.o,*.class,*.swp,*.bak,*.png,*.jpeg,*.jpg
set nocompatible
set commentstring=" \ #\ %s"
set foldlevel=0
set clipboard+=unnamed
set mouse=a
set spell spelllang=de
set nospell
set ls=2
set autochdir
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions
set title
set titlestring=%F

syntax on

filetype plugin indent on

autocmd Filetype html set ts=2 sts=2 sw=2
autocmd Filetype htmljinja set ts=2 sts=2 sw=2
autocmd Filetype javascript set ts=2 sts=2 sw=2
autocmd Filetype jinja set ts=2 sts=2 sw=2
autocmd Filetype scala set ts=2 sts=2 sw=2
autocmd FileType python set omnifunc=pythoncomplete#Complete

colorscheme elflord

let g:pydiction_location = '~/.vim/pydiction-1.2/complete-dict'

au BufRead,BufNewFile *.gradle  set filetype=groovy
au BufRead,BufNewFile *.sbt set filetype=scala
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

let g:syntastic_python_checker_args = '--rcfile=~/coding/python/pylintrc-pydev' 

set pastetoggle=<F8>
map <F6> :set number <CR>
map <F7> :set nonumber <CR>
map <C-T><C-H> :set filetype=htmljinja <CR>
map <C-T><C-K> :set filetype=coffee <CR>
map <C-T><C-P> :set filetype=python <CR>
map <F10> :w <CR> :make <CR>
