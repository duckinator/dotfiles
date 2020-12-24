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

autocmd FileType rb,yml setlocal shiftwidth=2

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

" Insert hard tab
imap <S-tab> <C-v><tab>

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
EOF
endfunction

call InitialSetup()


let g:ale_linters = {
\   'c': ['clangd'],
\   'python': ['pylint']
\}


" color scheme and such

set background=dark
"colorscheme slate
syntax on
" Make comments grey by default.
"exec 'highlight Comment term=bold ctermfg=lightgrey

let black=0
" aka "light black".
let lightblack=8
let darkgray=lightblack

let red=1
let lightred=9

let green=2
let lightgreen=10

let darkyellow=3
let brown=darkyellow
let lightyellow=11
let yellow=lightyellow

let blue=4
let lightblue=12

let magenta=5
let lightmagenta=13

let cyan=6
let lightcyan=14

" aka "dark white".
let lightgray=7
" aka "light white".
let white=15

let colors_name="puppy"
exec 'highlight Normal ctermfg='.white
highlight Cursor cterm=reverse

"exec 'highlight Cursor guibg=khaki guifg=slategrey
highlight VertSplit cterm=reverse
exec 'highlight Folded       ctermfg='.white.'      ctermbg='.darkgray
exec 'highlight FoldColumn   ctermfg='.blue.'       ctermbg='.lightgray
highlight IncSearch cterm=bold,reverse
exec 'highlight ModeMsg      ctermfg='.brown.'      cterm=none'
exec 'highlight MoreMsg      ctermfg='.green
exec 'highlight NonText      ctermfg='.blue.'       cterm=bold'
exec 'highlight Question     ctermfg='.green
exec 'highlight Search       cterm=bold,reverse'
exec 'highlight SpecialKey   ctermfg='.green
highlight StatusLine   cterm=bold,reverse
highlight StatusLineNC cterm=reverse
exec 'highlight Title        ctermfg='.yellow.'     cterm=bold'
exec 'highlight Statement    ctermfg='.lightblue
highlight Visual cterm=reverse
exec 'highlight WarningMsg   ctermfg='.red.'        cterm=bold'
exec 'highlight String       ctermfg='.cyan
exec 'highlight Comment      ctermfg='.lightcyan.'   cterm=bold'
exec 'highlight Constant     ctermfg='.brown
exec 'highlight Special      ctermfg='.brown
exec 'highlight Identifier   ctermfg='.red
exec 'highlight Include      ctermfg='.red
exec 'highlight PreProc      ctermfg='.red
exec 'highlight Operator     ctermfg='.red
exec 'highlight Define       ctermfg='.yellow
exec 'highlight Type         ctermfg='.green
exec 'highlight Function     ctermfg='.brown
exec 'highlight Structure    ctermfg='.green
exec 'highlight LineNr       ctermfg='.brown
exec 'highlight Ignore       ctermfg='.lightgray.'  cterm=bold'
exec 'highlight Todo         ctermfg='.lightcyan.'   ctermbg='.yellow
exec 'highlight Directory    ctermfg='.cyan
exec 'highlight ErrorMsg     ctermfg='.white.'      ctermbg='.red.'   cterm=bold'
highlight VisualNOS cterm=bold,underline
exec 'highlight WildMenu     ctermfg='.black.'      ctermbg='.brown
exec 'highlight DiffAdd      ctermfg='.white.'      ctermbg='.blue
exec 'highlight DiffChange   ctermfg='.white.'      ctermbg='.magenta
exec 'highlight DiffDelete   ctermfg='.blue.'       ctermbg='.cyan.'  cterm=bold'
exec 'highlight DiffText     ctermfg='.white.'      ctermbg='.red.'   cterm=bold'
exec 'highlight Underlined   ctermfg='.magenta.'    cterm=underline'
exec 'highlight Error        ctermfg='.white.'      ctermbg='.red.'   cterm=bold'
exec 'highlight SpellErrors  ctermfg='.white.'      ctermbg='.red.'   cterm=bold'
