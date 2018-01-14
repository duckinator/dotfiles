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

function! LoadEditorconfig()
python3 << EOF
from configparser import SafeConfigParser
import subprocess
import os
import vim

def try_section(section, items):
    for (k, v) in items:
        command = []
        if k == "indent_style":
            if v == "space":
                command.append("expandtab")
            elif v == "tab":
                command.append("noexpandtab")
        if k == "indent_size":
            command.append("shiftwidth=" + v)
        if len(command) > 0:
            command_str = "au BufReadPost,BufNewFile " + section + " set " + " ".join(command)
            vim.eval("execute(\"{}\")".format(command_str.replace('"', '\\"')))

def load_editorconfig(git_dir):
    if git_dir is None:
      return
    config = os.path.join(git_dir, ".editorconfig")
    if os.path.isfile(config):
        parser = SafeConfigParser()
        parser.read(config)
        for section_name in parser.sections():
            try_section(section_name, parser.items(section_name))

def git_root_dir():
    command = "git rev-parse --show-toplevel"
    result = subprocess.getoutput(command).strip()
    if result.startswith("fatal:"):
      return None
    else:
      return result

load_editorconfig(git_root_dir())
EOF
endfunction

call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-signify'
Plug 'rust-lang/rust.vim'

call plug#end()

set background=dark
colo ThemerVim
