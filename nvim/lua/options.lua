-- help
vim.cmd [[autocmd FileType help wincmd L]]

vim.cmd [[
syntax on
filetype plugin indent on
]]

-- buffer
vim.opt.hidden = true
vim.opt.autowrite = true

-- status line
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.ruler = false

-- commandmode
vim.opt.wildmenu = true
vim.opt.history = 5000

-- tab indent
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2

-- string
-- only capital letter
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- <C-h> setting
-- I use Karabiner-element and here, I change <C-h> to delete.
-- vim.opt.backspace = 'indent,eol,start'

-- (){} corresponding
vim.opt.showmatch = true
vim.opt.matchtime = 2

vim.opt.whichwrap = 'b,s,h,l,<,>,[,],~'
vim.opt.relativenumber = true
vim.opt.number = true
vim.cmd [[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]]
vim.opt.cursorline = true
vim.opt.completeopt = 'menu,menuone'

-- vim.opt.wildchar='<C-n>'
vim.cmd [[
set wildchar=<Tab>
set wildcharm=<Tab>
]]
vim.opt.wildmode = 'full'

-- spell checker
vim.cmd [[
  autocmd FileType markdown setlocal spell spelllang=en,cjk
  autocmd FileType text setlocal spell spelllang=en,cjk
  autocmd FileType gitcommit setlocal spell spelllang=en,cjk
]]
