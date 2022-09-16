if g:dein#_cache_version !=# 150 || g:dein#_init_runtimepath !=# '/Users/gotoutoshiki/.config/nvim,/etc/xdg/nvim,/Users/gotoutoshiki/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime,/usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/pack/dist/opt/termdebug,/usr/local/Cellar/neovim/0.7.2_1/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/gotoutoshiki/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/gotoutoshiki/.config/nvim/after,/Users/gotoutoshiki/.vim/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/gotoutoshiki/config/nvim-setting/nvim/init.lua', '/Users/gotoutoshiki/.config/nvim/config/dein.toml', '/Users/gotoutoshiki/.config/nvim/config/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/gotoutoshiki/.config/nvim/dein'
let g:dein#_runtime_path = '/Users/gotoutoshiki/.config/nvim/dein/.cache/init.lua/.dein'
let g:dein#_cache_path = '/Users/gotoutoshiki/.config/nvim/dein/.cache/init.lua'
let &runtimepath = '/Users/gotoutoshiki/.config/nvim,/etc/xdg/nvim,/Users/gotoutoshiki/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/Users/gotoutoshiki/.config/nvim/dein/.cache/init.lua/.dein,/usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime,/Users/gotoutoshiki/.config/nvim/dein/.cache/init.lua/.dein/after,/usr/local/Cellar/neovim/0.7.2_1/share/nvim/runtime/pack/dist/opt/termdebug,/usr/local/Cellar/neovim/0.7.2_1/lib/nvim,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/gotoutoshiki/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/gotoutoshiki/.config/nvim/after,/Users/gotoutoshiki/.vim/dein/repos/github.com/Shougo/dein.vim'
filetype off
let g:lightline = { 'colorscheme': 'one', 'active': {   'left': [ [ 'mode', 'paste' ],             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],   'right': [ [ 'lineinfo' ],              [ 'percent' ],              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ] }, 'component': {   'charvaluehex': '0x%B', }, 'component_function': {   'gitbranch': 'FugitiveHead', }, }
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_auto_colors = 0
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=239
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237
    let g:indent_guides_guide_size = 1
    let g:indent_guides_start_level =2
    let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.php,*.vue,*.rb'
