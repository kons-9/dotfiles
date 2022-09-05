" commandmode
set wildmenu " コマンドモードの補完
set history=5000 

" " tab indent
" set expandtab 
" set tabstop=4
" set softtabstop=4 
" set autoindent
" set smartindent
" set shiftwidth=4
" set softtabstop=4

" string
" only capital letter
set incsearch
set ignorecase
set smartcase " if search pattern has Capital letter, not ignore.
set hlsearch " you can disable this setting :noh temporary

" <C-h> setting
set backspace=indent,eol,start

" (){} corresponding
set showmatch 
set matchtime=2

" <Leader> mapping
let mapleader=" "

" decimal number
set nrformats=

" carsor movement
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

set whichwrap=b,s,h,l,<,>,[,],~
set number
set cursorline

" command history setting
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" buflist setting
set hidden autowrite

" complete
" https://note.com/yasukotelin/n/na87dc604e042
set completeopt=menu,noinsert
" set previewheight=6
inoremap <expr><CR> pumvisible() ? "<C-y>" : "<CR>"
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" path
let g:python3_host_prog='/Library/Frameworks/Python.framework/Versions/3.8/bin/python3'

" etc...
inoremap {<C-o>o {}<Left><CR><UP><C-o>o
cnoremap <expr>%% getcmdtype()==':'?expand('%:h').'/': '%%'
set clipboard+=unnamed

" vscode plugin
source $VIMRUNTIME/macros/matchit.vim
source ~/.config/nvim/dein/repos/github.com/tpope/vim-surround/plugin/surround.vim

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine
