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
set nospell
set spelllang=de
set ls=2
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions
set title
set titlestring=%F
set hlsearch
set textwidth=0

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
autocmd! BufRead,BufNewFile *.ics setfiletype icalendar
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"let g:syntastic_python_checker_args = '--rcfile=~/coding/python/pylintrc-pydev' 
"let g:syntastic_python_checker_args = '--ignore=E501'
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

" change buffer with single click
let g:miniBufExplUseSingleClick = 1
" force MBE to try to place selected
" buffers into a window that does not have a nonmodifiable buffer.
" The upshot of this should be that if you go into MBE and select
" a buffer, the buffer should not show up in a window that is
" hosting an explorer.
 let g:miniBufExplModSelTarget = 1

" let the NERDTree ignore some file type (generated stuff and the like)
let NERDTreeIgnore=['\.vim$', '\~$', '\.js$', '\.map$', '\.pyc$']


"Jedi
let g:jedi#popup_on_dot = 0


let g:ack_default_options= " -s --nocolor --nogroup --column"


let g:unite_yarm_server_url = 'http://localhost:3000'
let g:unite_yarm_access_key  = '012cb36858fed5b1637f913677c9362eaf71f128'


"Unite
let g:unite_source_grep_command = "ag"
let g:unite_source_grep_default_opts = "--nogroup --nocolor --column"
let g:unite_source_history_yank_enable = 1
"let g:unite_winheight = 30
nmap <space> [unite]
nnoremap [unite]/ :Unite -no-split grep:.<cr>
nnoremap [unite]y :Unite -no-split history/yank<cr>
nnoremap [unite]s :Unite -no-split -quick-match buffer<cr>
nnoremap [unite]f :Unite -no-split file_rec -start-insert<cr>
nnoremap [unite]u :Unite 
nnoremap [unite]o :Unite -no-split -start-insert -auto-preview outline<cr>
