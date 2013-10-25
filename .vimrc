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
set hlsearch

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
autocmd! BufRead,BufNewFile *.ics setfiletype icalendar
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"let g:syntastic_python_checker_args = '--rcfile=~/coding/python/pylintrc-pydev' 
let g:syntastic_python_checker = 'flake8'
let g:syntastic_python_checker_args = '--ignore=E501'
set pastetoggle=<C-T><C-T>
map <C-P><C-P> :set number <CR> :set mouse=a <CR>
map <C-P><C-O> :set nonumber <CR> :set mouse-=a <CR>
map <C-P><C-D> "=strftime("%d.%m.%Y")<CR>P
map <C-T><C-H> :set filetype=htmljinja <CR>
map <C-T><C-K> :set filetype=coffee <CR>
map <C-T><C-P> :set filetype=python <CR>
map <F10> :w <CR> :make <CR>
map <F3> :NERDTreeToggle<CR>
map <leader>d <Plug>Kwbd<CR>
map <C-A> "_ddP

nmap gt :bn<CR>
nmap gT :bp<CR>
nmap g0 :bfirst<CR>
nmap g$ :blast<CR>

" change buffer with single click
let g:miniBufExplUseSingleClick = 1
" force MBE to try to place selected
" buffers into a window that does not have a nonmodifiable buffer.
" The upshot of this should be that if you go into MBE and select
" a buffer, the buffer should not show up in a window that is
" hosting an explorer.
 let g:miniBufExplModSelTarget = 1

" let the NERDTree ignore some file type (generated stuff and the like)
let NERDTreeIgnore=['\.vim$', '\~$', '\.js$', '\.map$']
