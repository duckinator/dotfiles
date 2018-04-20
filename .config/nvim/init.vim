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

inoremap <F5> :update<Bar>execute '!./build.sh '.shellescape(expand('%'), 1)<CR>
nnoremap <F5> :update<Bar>execute '!./build.sh '.shellescape(expand('%'), 1)<CR>

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
"colorscheme slate
syntax on
" Make comments grey by default.
"highlight Comment term=bold ctermfg=lightgrey

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
highlight Normal ctermfg=white
highlight Cursor cterm=reverse

"highlight Cursor guibg=khaki guifg=slategrey
highlight VertSplit    cterm=reverse
highlight Folded       ctermfg=grey      ctermbg=darkgrey
highlight FoldColumn   ctermfg=blue      ctermbg=lightgray
highlight IncSearch    cterm=bold,reverse
highlight ModeMsg      ctermfg=brown                     cterm=none
highlight MoreMsg      ctermfg=green
highlight NonText      ctermfg=blue                      cterm=bold
highlight Question     ctermfg=green
highlight Search       cterm=bold,reverse
highlight SpecialKey   ctermfg=green
highlight StatusLine   cterm=bold,reverse
highlight StatusLineNC cterm=reverse
highlight Title        ctermfg=yellow                    cterm=bold
highlight Statement    ctermfg=lightblue
highlight Visual       cterm=reverse
highlight WarningMsg   ctermfg=red                       cterm=bold
highlight String       ctermfg=cyan
highlight Comment      ctermfg=grey                      cterm=bold
highlight Constant     ctermfg=brown
highlight Special      ctermfg=brown
highlight Identifier   ctermfg=red
highlight Include      ctermfg=red
highlight PreProc      ctermfg=red
highlight Operator     ctermfg=red
highlight Define       ctermfg=yellow
highlight Type         ctermfg=green
highlight Function     ctermfg=brown
highlight Structure    ctermfg=green
highlight LineNr       ctermfg=brown
highlight Ignore       ctermfg=lightgray                 cterm=bold
highlight Todo         ctermfg=darkgray  ctermbg=yellow
highlight Directory    ctermfg=cyan
highlight ErrorMsg     ctermfg=white     ctermbg=red     cterm=bold
highlight VisualNOS                                      cterm=bold,underline
highlight WildMenu     ctermfg=black     ctermbg=brown
highlight DiffAdd      ctermfg=white     ctermbg=blue
highlight DiffChange   ctermfg=white     ctermbg=magenta
highlight DiffDelete   ctermfg=blue      ctermbg=cyan    cterm=bold
highlight DiffText     ctermfg=white     ctermbg=red     cterm=bold
highlight Underlined   ctermfg=magenta   cterm=underline
highlight Error        ctermfg=white     ctermbg=red     cterm=bold
highlight SpellErrors  ctermfg=white     ctermbg=red    cterm=bold
