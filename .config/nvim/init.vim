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
autocmd FileType c,cpp,java,lua setlocal sw=4
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
nmap <leader>s :set spell!<CR>
nmap <leader>r :set relativenumber!<CR>

nmap <C-n> :tabnext<CR>
nmap <C-p> :tabprev<CR>
nmap <C-o> :tabedit<Space>

nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>i
nmap <C-q> :q<CR>

nmap Y y$

inoremap <F5> :update<Bar>execute '!./build.sh '.shellescape(expand('%'), 1)<CR><CR>
nnoremap <F5> :update<Bar>execute '!./build.sh '.shellescape(expand('%'), 1)<CR><CR>

" Insert hard tab
imap <S-tab> <C-v><tab>

function! LoadEditorconfig()
python3 << EOF
from configparser import SafeConfigParser
import subprocess
import os
import vim

def reject_none(items):
    return filter(lambda x: not x is None, items)

def config_item(t):
    (k, v) = t
    if k == "indent_size":
        return "shiftwidth=" + v
    elif k == "indent_style":
        if v == "space":
            return "expandtab"
        else:
            return "noexpandttab"
    else:
        return None

def add_section(section):
    command = list(reject_none(map(config_item, section.items())))
    if len(command) > 0:
      return "au BufReadPost,BufNewFile " + section.name + " set " + " ".join(command)
    else:
      return None

def load_editorconfig_for(path):
    config = os.path.join(path, ".editorconfig")
    if not os.path.isfile(config):
        return
    parser = SafeConfigParser()
    parser.read(config)
    commands = reject_none(map(add_section, parser.values()))
    for command in commands:
        vim.eval("execute(\"{}\")".format(command.replace('"', '\\"')))

def load_editorconfig():
    command = "git rev-parse --show-toplevel"
    result = subprocess.getoutput(command).strip()
    if not result.startswith("fatal:"):
        load_editorconfig_for(result)

load_editorconfig()
EOF
endfunction
nmap <leader>e :call LoadEditorconfig()<CR>

function! InitialSetup()
python3 << EOF
from pathlib import Path
import subprocess

dir = Path("~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim/").expanduser()
repo_url = "https://github.com/Shougo/dein.vim"

if not dir.is_dir():
    subprocess.check_output(["git", "clone", repo_url, str(dir)])
EOF
endfunction

call InitialSetup()
set runtimepath+=~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim/
if dein#load_state('~/.config/nvim/bundle')
  call dein#begin('~/.config/nvim/bundle')
  call dein#add('~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim/')

  call dein#add('Shougo/deoplete.nvim')
  call dein#add('mhinz/vim-signify')
  call dein#add('rust-lang/rust.vim')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

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
exec 'highlight Comment      ctermfg='.darkgray.'   cterm=bold'
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
exec 'highlight Todo         ctermfg='.darkgray.'   ctermbg='.yellow
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
