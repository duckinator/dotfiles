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
nmap <leader>s :set spell!<CR>
nmap <leader>r :set relativenumber!<CR>

nmap Y y$

" Insert hard tab
imap <S-tab> <C-v><tab>

let dein_install_dir = "~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim/"
call system("bash -c 'test -f ".dein_install_dir." || mkdir -p ".dein_install_dir." && git clone https://github.com/Shougo/dein.vim ".dein_install_dir."'")

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
colo ThemerVim
syntax on
