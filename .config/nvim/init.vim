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
set nowrap " don't automatically insert newlines.
syntax on

set statusline+=%t      "tail of the filename
set statusline+=\ %y    "filetype
set statusline+=\ %m    "modified flag
set statusline+=%=      "left/right separator
set statusline+=%l,%c   "cursor column
set statusline+=\ %P\   "percent through file
set statusline+=%r      "read only flag

" Set updatetime so vim-gitgutter behaves nicer.
" May be worth tweaking.
" https://github.com/airblade/vim-gitgutter#getting-started
set updatetime=100

" Jump to the last cursor position when opening
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

" Default to 2-space indents, 4-character tabs
set expandtab
set shiftwidth=4
set tabstop=4
filetype plugin indent on

autocmd FileType js,rb,yml setlocal shiftwidth=2

autocmd FileType rs setlocal noexpandtab shiftwidth=4

" Makefiles require hard tabs.
autocmd FileType make setlocal noexpandtab shiftwidth=4 softtabstop=0
autocmd FileType ld setlocal noexpandtab shiftwidth=4 softtabstop=0

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

nmap <F1> :!~/bin/try-open-docs<CR>
imap <F1> <Esc><F1>

nmap <F2> :!~/bin/try-build<CR>
imap <F2> <Esc><F2>

nmap <F5> :!~/bin/try-run-tests<CR>
imap <F5> <Esc><F5>

nmap <leader>n :nohlsearch<CR>
nmap <leader>s :set spell!<CR>
nmap <leader>r :set relativenumber!<CR>

nmap <C-n> :tabnext<CR>
nmap <C-p> :tabprev<CR>
nmap <C-o> :tabedit<Space>

nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a
nmap <C-q> :q<CR>

" Yank to end of line
nmap Y y$

imap <S-tab> <C-d>

" Insert hard tab
imap <C-tab> <C-v><tab>

function! InitialSetup()
python3 << EOF
from pathlib import Path
import subprocess

root_dir = Path("~/.config/nvim/pack/repos/start/").expanduser()

if not root_dir.exists():
  root_dir.mkdir(parents=True)

def ensure_pack(repo):
    repo_url = "https://github.com/{}.git".format(repo)
    dir = root_dir / repo.replace("/", "__")
    if not dir.is_dir():
        subprocess.check_output(["git", "clone", repo_url, str(dir)])

ensure_pack("mhinz/vim-signify")
ensure_pack("dense-analysis/ale")
ensure_pack("rust-lang/rust.vim")
EOF
endfunction

call InitialSetup()


let g:ale_linters = {
\   'c': ['clangd'],
\   'python': ['pylint'],
\   'ruby': [],
\   'rust': ['cargo', 'rust-analyzer'],
\}

let g:ale_virtualtext_cursor='disabled'

" color scheme and such

set background=dark
"colorscheme slate
syntax on
" Make comments grey by default.
"exec 'highlight Comment term=bold ctermfg=lightgrey
