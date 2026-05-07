vim.g.mapleader = ' '

vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'ucs-boms,utf-8,euc-jp,cp932'
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.ambiwidth = 'single'

local map = vim.keymap.set

-- buflist setting
map('n', '[b', ':bprevious<CR>', { desc = 'previous buffer' })
map('n', ']b', ':bnext<CR>', { desc = 'next buffer' })
map('n', '[B', ':bfirst<CR>', { desc = 'first buffer' })
map('n', ']B', ':blast<CR>', { desc = 'last buffer' })

-- cursor movement
map('n', 'j', 'gj', { desc = 'move down' })
map('n', 'k', 'gk', { desc = 'move up' })
map('n', '<down>', 'gj', { desc = 'move down' })
map('n', '<up>', 'gk', { desc = 'move up' })

-- command history setting
map('c', '<C-p>', '<Up>', { desc = 'command history up' })
map('c', '<C-n>', '<Down>', { desc = 'command history down' })
map('c', '<C-J>', '<C-n>', { desc = 'command history down' })
map('c', '<C-K>', '<C-p>', { desc = 'command history up' })

-- disable arrow
map('n', '<Up>', 'H', { desc = 'move to first' })
map('n', '<Down>', 'L', { desc = 'move to last' })
map('n', '<Left>', '<Nop>', { desc = 'disable arrow' })
map('n', '<Right>', '<Nop>', { desc = 'disable arrow' })

-- first last
map('n', 'H', '^', { desc = 'move to first' })
map('n', 'L', '$', { desc = 'move to last' })
map('o', 'H', '^', { desc = 'move to first' })
map('o', 'L', '$', { desc = 'move to last' })
map('v', 'H', '^', { desc = 'move to first' })
map('v', 'L', '$', { desc = 'move to last' })

-- nohighlight
map('n', '<C-h>', ':noh<cr>', { desc = 'nohighlight' })
map('n', '<BS>', ':noh<cr>', { desc = 'nohighlight' })

-- etc
map('c', '%%', "getcmdtype()==':'?expand('%:h').'/': '%%'", { expr = true, desc = 'expand parent directory' })

-- terminal
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'exit terminal' })
map('t', '<C-[>', '<C-\\><C-n>', { desc = 'exit terminal' })
vim.api.nvim_create_autocmd('TermOpen', { command = 'startinsert' })

-- help
vim.api.nvim_create_autocmd('FileType', { pattern = 'help', command = 'wincmd L' })

vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

-- window
vim.opt.splitright = true
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
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4

-- search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- matching
vim.opt.showmatch = true
vim.opt.matchtime = 2

vim.opt.whichwrap = 'b,s,h,l,<,>,[,],~'
vim.opt.relativenumber = false
vim.opt.number = true

local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
    group = numbertoggle,
    pattern = '*',
    command = 'if &nu && mode() != "i" | set rnu | endif',
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
    group = numbertoggle,
    pattern = '*',
    command = 'if &nu | set nornu | endif',
})

vim.opt.cursorline = true
vim.opt.completeopt = 'menu,menuone'

vim.opt.wildcharm = ('\t'):byte()
vim.opt.wildchar = ('\t'):byte()
vim.opt.wildmode = 'full'

-- spell checker
local spell_group = vim.api.nvim_create_augroup('spell', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = spell_group,
    pattern = 'markdown,text,gitcommit',
    command = 'setlocal spell spelllang=en,cjk',
})
