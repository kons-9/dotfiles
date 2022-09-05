" status line
set laststatus=2
set noshowmode
set showcmd
set noruler

" commandmode
set wildmenu " コマンドモードの補完
set history=5000 

" tab indent
set expandtab 
set tabstop=2
set softtabstop=2 
set autoindent
set smartindent
set shiftwidth=2

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

" comment setting
" set formatoptions-=ro
" nnoremap <Leader>o o
" nnoremap <Leader>O O
" nnoremap o :<C-u>call append(expand('.'), '')<Cr>ji
" nnoremap O Oa<C-u>
nnoremap <C-n> :<C-u>call append(expand('.'), '')<Cr>j

" decimal number
set nrformats=

" colorscheme
" colorscheme molokai
" colorscheme hybrid
" colorscheme iceberg
colorscheme myiceberg
set t_Co=256
syntax enable
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight SpecialKey ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE ctermfg=241 guibg=NONE guifg=#444b71
hi Visual ctermfg=NONE ctermbg=240

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
nnoremap <silent>[b :bprevious<CR>
nnoremap <silent>]b :bnext<CR>
nnoremap <silent>[B :bfirst<CR>
nnoremap <silent>]B :blast<CR>
set hidden autowrite

" debug setting
packadd termdebug
let g:termdebug_wide = 160

" disable arrow
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" complete
" https://note.com/yasukotelin/n/na87dc604e042
set completeopt=menu,noinsert
" whether pop up menu is visible
inoremap <expr><CR> pumvisible() ? "<C-y>" : "<CR>"
inoremap <expr><C-n> pumvisible() ? "<Down>" : "<C-n>"
inoremap <expr><C-p> pumvisible() ? "<Up>" : "<C-p>"

" path
let g:python3_host_prog='/Library/Frameworks/Python.framework/Versions/3.8/bin/python3'

" nvim setting
" terminal
let $LANG="en_US"
let $LC_CTYPE="UTF-8"
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * startinsert

" etc...
inoremap {<C-o>o {}<Left><CR><UP><C-o>o
cnoremap <expr>%% getcmdtype()==':'?expand('%:h').'/': '%%'
snoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR
" set clipboard+=unnamed
source $VIMRUNTIME/macros/matchit.vim
