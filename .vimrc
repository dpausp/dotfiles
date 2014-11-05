set nocompatible

call pathogen#infect()
"inoremap <Nul> <C-x><C-n>



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
set commentstring=" \ #\ %s"
set foldlevel=0
set clipboard+=unnamed
set mouse=a
set nospell
set spelllang=de
set ls=2
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions
set title
set titlestring=%F
set hlsearch
set textwidth=0
set history=1000
set undolevels=1000

syntax on

filetype plugin indent on



autocmd Filetype html set ts=2 sts=2 sw=2
autocmd Filetype javascript set ts=2 sts=2 sw=2
autocmd Filetype jinja set ts=2 sts=2 sw=2
autocmd Filetype htmljinja set ts=2 sts=2 sw=2
autocmd Filetype scala set ts=2 sts=2 sw=2
autocmd Filetype jade set ts=2 sts=2 sw=2
autocmd Filetype ruby set ts=2 sts=2 sw=2
autocmd Filetype python set ts=4 sts=4 sw=4

colorscheme elflord

au BufRead,BufNewFile *.gradle  set filetype=groovy
au BufRead,BufNewFile *.j2* set filetype=htmljinja
au BufRead,BufNewFile *.html.j2 set filetype=htmljinja
au BufRead,BufNewFile *.j2.html set filetype=htmljinja
au BufRead,BufNewFile *.sbt set filetype=scala
au BufRead,BufNewFile *.nix set filetype=nix
au BufRead,BufNewFile *.robot set filetype=robot
autocmd! BufRead,BufNewFile *.ics setfiletype icalendar
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"let g:syntastic_python_checker_args = '--rcfile=~/coding/python/pylintrc-pydev' 
"let g:syntastic_python_checker_args = '--ignore=E501'

let mapleader=","
set pastetoggle=<C-T><C-T>
map <C-P><C-P> :set number mouse=a <CR>
map <C-P><C-O> :set nonumber mouse-=a <CR>
map <C-P><C-D> "=strftime("%d.%m.%Y")<CR>P
map <C-T><C-H> :set filetype=htmljinja <CR>
map <C-T><C-I> :set filetype=jinja <CR>
map <C-T><C-K> :set filetype=coffee <CR>
map <C-T><C-P> :set filetype=python <CR>
map <C-T><C-J> :set filetype=jade <CR>
map <C-T><C-M> :set filetype=markdown <CR>
map <F10> :w <CR> :make <CR>
map <F3> :NERDTreeToggle<CR>
map <leader>d <Plug>Kwbd<CR>
map <C-A> "_ddP
map <C-F><C-F> :%s/\| {%/-/g\|:%s/%}//g<CR>

map <F7> :Ack <CR>

nmap gt :bn<CR>
nmap gT :bp<CR>
nmap g0 :bfirst<CR>
nmap g$ :blast<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nmap <silent> <leader>/ :nohlsearch<CR>


" NERDTree
" let the NERDTree ignore some file type (generated stuff and the like)
let NERDTreeIgnore=['\.vim$', '\~$', '\.js$', '\.map$', '\.pyc$']


"Jedi
let g:jedi#popup_on_dot = 0

"Unite
let g:unite_source_grep_command = "ag"
let g:unite_source_grep_default_opts = "--nogroup --nocolor --column"
let g:unite_source_history_yank_enable = 1
let g:unite_winheight = 50
nmap <space> [unite]
nnoremap [unite]/ :Unite -no-split -auto-preview grep:.<cr>
nnoremap [unite]y :Unite -no-split history/yank<cr>
nnoremap [unite]s :Unite -no-split -quick-match buffer<cr>
nnoremap [unite]f :Unite -no-split file_rec -start-insert<cr>
nnoremap [unite]u :Unite 
nnoremap [unite]o :Unite -no-split -start-insert -auto-preview outline<cr>
nnoremap [unite]m :Unite -no-split -start-insert file_mru<cr>

"vim-pandoc
let g:pandoc#folding#fdc = 0

"pandoc commands

:command -nargs=+ Pd %!pandoc --no-wrap <args> -


"neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete = 1
imap <expr><C-Space>        neocomplete#start_manual_complete()
imap <C-@> <C-Space>
