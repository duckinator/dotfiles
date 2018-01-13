set nocompatible

set backspace=indent,eol,start
set backup
set history=50
set ruler
set showcmd
set incsearch
set ignorecase
set smartcase
set autoindent
set smartindent
set number
set colorcolumn=75
set title
set shortmess=I
set visualbell t_vb=
set cursorline
set smarttab
set hlsearch
set list
set listchars=tab:»·,trail:·
set laststatus=2
set scrolloff=1000 " always center except at the top/bottom of files.
set termguicolors
syntax on

set statusline+=%t      "tail of the filename
set statusline+=\ %y    "filetype
set statusline+=\ %m    "modified flag
set statusline+=%=      "left/right separator
set statusline+=%l,%c   "cursor column
set statusline+=\ %P\   "percent through file
set statusline+=%r      "read only flag

" Jump to the last cursor position when opening
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

" Default to 2-space indents, 4-character tabs
set expandtab
set shiftwidth=2
set tabstop=4
filetype plugin indent on

" Indentation exceptions
autocmd FileType c,cpp,lua setlocal sw=4
autocmd FileType markdown setlocal tw=72

" Makefiles require hard tabs.
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
autocmd FileType ld set noexpandtab shiftwidth=4 softtabstop=0

" C/C++ indent options
" :0  Align case with switch
" l1  Indent case bodies with braces to case
" g0  Align "public:" and friends to class
set cinoptions=:0,l1,g0

" Better tab-complete when opening
set wildmenu
set wildmode=list:longest
set wildignore=*.o,*.d,*~

" Remap leader to ,
noremap \ ,
let mapleader = ","

nmap <leader>n :nohlsearch<CR>
nmap <leader>l :set list!<CR>
nmap <leader>s :set spell!<CR>
nmap <leader>r :set relativenumber!<CR>

nmap Y y$

" Insert hard tab
imap <S-tab> <C-v><tab>

" Plugins

call plug#begin('~/.vim/plugged')

" Show git diff information along the left side.
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['git']
let g:signify_sign_overwrite = 1
let g:signify_sign_change = '~'

Plug 'rust-lang/rust.vim'

call plug#end()

set background=dark
colo ThemerVim
