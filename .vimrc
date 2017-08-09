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
syntax on

" Enable mouse in terminals
if has('mouse')
  set mouse=a
endif

" Less clutter in terminals
if !has('gui_running')
  set nospell
endif

" GUI options
set guioptions-=mrLtT " Disable menus, toolbar, scrollbars
set guioptions+=c " Disable GUI dialogs
set guifont=Monospace\ 9
set browsedir=buffer " Open dialog starts in working directory

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

" C/C++ indent options
" :0  Align case with switch
" l1  Indent case bodies with braces to case
" g0  Align "public:" and friends to class
set cinoptions=:0,l1,g0

" Indent Compojure correctly
autocmd FileType clojure set lispwords+=GET,POST,PUT,DELETE

" Better tab-complete when opening
set wildmenu
set wildmode=list:longest
set wildignore=*.o,*.d,*~

" Smarter %
" ??? not sure what this is.
"runtime macros/matchit.vim

" Disable visible whitespace in insert mode
"autocmd InsertEnter * setlocal nolist
"autocmd InsertLeave * setlocal list

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

command! W :w

" Plugins

call plug#begin('~/.vim/plugged')

" Far nicer modeline.
" https://github.com/vim-airline/vim-airline
Plug 'bling/vim-airline'
set noshowmode
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#whitespace#enabled = 0

" Run syntax checker for some files and tell you where there's an error.
Plug 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" Show git diff information along the left side.
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['git']
let g:signify_sign_overwrite = 1
let g:signify_sign_change = '~'

Plug 'kien/ctrlp.vim'
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>e :CtrlP<CR>
nmap <leader>t :CtrlPBufTag<CR>
nmap <leader>l :CtrlPLine<CR>

"Plug 'tpope/vim-fugitive'
"nmap <leader>gs :Gstatus<CR>
"nmap <leader>gc :Gcommit<CR>
"nmap <leader>gp :Git push<CR>

Plug 'junegunn/vim-easy-align'
"vnoremap <silent> <Enter> :EasyAlign<Enter> " ??? I'm not sure what this does?

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Auto-indentation and auto-inserting brackets/parens/quotes.
" https://github.com/jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'

" Class outline viewer.
" https://github.com/majutsushi/tagbar
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" Keybindings used for vim splits.
" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Plug 'mattn/webapi-vim'

Plug 'programble/itchy.vim'
Plug 'programble/jellybeans.vim'

" Makes pasting things in vim nicer.
" https://github.com/sickill/vim-pasta
Plug 'sickill/vim-pasta'

" For manipulating code comments.
" https://github.com/tpope/vim-commentary
"Plug 'tpope/vim-commentary'

" Helps end structures automatically -- e.g. end after if/do/def in Ruby.
" https://github.com/tpope/vim-endwise
Plug 'tpope/vim-endwise'

"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-ragtag'

Plug 'rust-lang/rust.vim'

call plug#end()

colorscheme jellybeans
