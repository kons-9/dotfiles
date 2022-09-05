" dein setting
if has('nvim')
    let s:dein_dir = expand('~/.config/nvim/dein')
    let s:toml_dir = expand('~/.config/nvim/config')
else
    let s:dein_dir = expand('~/.vim/dein')
    let s:toml_dir = expand('~/.vim/config')
endif
" 
let s:dein = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
set runtimepath+=$HOME/.vim/dein/repos/github.com/Shougo/dein.vim
" 
" " Required:
 if dein#load_state(s:dein_dir)
     call dein#begin(s:dein_dir)
 
     " Let dein manage dein
     let s:toml = s:toml_dir . '/dein.toml'
     let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
 
     call dein#load_toml(s:toml, {'lazy': 0})
     call dein#load_toml(s:lazy_toml, {'lazy': 1})
     call dein#end()
     call dein#save_state()
 
     " Required:
     filetype plugin indent on
     syntax enable
 endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


