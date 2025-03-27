-- vscode settings
vim.cmd [[set incsearch]]
vim.cmd [[set ignorecase]]
vim.cmd [[set smartcase " if search pattern has Capital letter, not ignore.]]
vim.cmd [[set hlsearch " you can disable this setting :noh temporary]]

vim.cmd [[xmap gc  <Plug>VSCodeCommentary]]
vim.cmd [[nmap gc  <Plug>VSCodeCommentary]]
vim.cmd [[omap gc  <Plug>VSCodeCommentary]]
vim.cmd [[nmap gcc <Plug>VSCodeCommentaryLine]]
vim.cmd [[set clipboard+=unnamed]]

local vscode = require('vscode')

vim.keymap.set('n', '<leader><C-t>', function() vscode.action('workbench.action.terminal.toggleTerminal') end, { desc = 'open terminal' })

vim.keymap.set('n', '[b', function() vscode.action('workbench.action.previousEditor') end, { desc = 'previous buffer' })
vim.keymap.set('n', ']b', function() vscode.action('workbench.action.nextEditor') end, { desc = 'next buffer' })
