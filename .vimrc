set nocompatible

set backspace=indent,eol,start
set hidden
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
set spell
set colorcolumn=80
set title
set shortmess=atI
set visualbell t_vb=
set cursorline
set smarttab
set hlsearch
set list
set listchars=tab:»·,trail:·
set foldmethod=syntax
set foldlevel=1000
set laststatus=2
set scrolloff=1
set nospell
syntax on

" Enable mouse in terminals
if has('mouse')
  set mouse=a
endif

" Jump to the last cursor position when opening
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

au BufRead,BufNewFile *.styl setfiletype css

" Default to 2-space indents, 4-character tabs
set expandtab
set shiftwidth=2
set tabstop=4
set shiftround
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

" Custom maps
nnoremap ' `
nnoremap ` '

nmap <leader>n :nohlsearch<CR>

nmap <leader>s :set list!<CR>

nmap <leader>z :set spell!<CR>

nmap <leader>p "+p
nmap <leader>P "+P
nmap <leader>y "+y
nmap <leader>Y "+Y
nmap <leader>d "+d
nmap <leader>D "+D

nmap Y y$

" Insert hard tab
imap <S-tab> <C-v><tab>

" Toggle relative/absolute numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nmap <C-n> :call NumberToggle()<CR>

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
