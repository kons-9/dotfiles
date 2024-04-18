-- leader
g.mapleader = ' '

-- buflist setting
utils.keymap('n', '[b', ':bprevious<CR>', { desc = 'previous buffer' })
utils.keymap('n', ']b', ':bnext<CR>', { desc = 'next buffer' })
utils.keymap('n', '[B', ':bfirst<CR>', { desc = 'first buffer' })
utils.keymap('n', ']B', ':blast<CR>', { desc = 'last buffer' })

-- carsor movement
utils.keymap('n', 'j', 'gj', { desc = 'move down' })
utils.keymap('n', 'k', 'gk', { desc = 'move up' })
utils.keymap('n', '<down>', 'gj', { desc = 'move down' })
utils.keymap('n', '<up>', 'gk', { desc = 'move up' })

-- command history setting
utils.keymap('c', '<C-p>', '<TAB>', { desc = 'command history up' })
utils.keymap('c', '<C-n>', '<S-TAB>', { desc = 'command history down' })
-- vim.cmd [[set esckeys]]
utils.keymap('c', '<C-J>', '<C-n>', { desc = 'command history down' })
utils.keymap('c', '<C-K>', '<C-p>', { desc = 'command history up' })

-- disable arrow
utils.keymap('n', '<Up>', 'H', { desc = 'move to first' })
utils.keymap('n', '<Down>', 'L', { desc = 'move to last' })
utils.keymap('n', '<Left>', '<Nop>', { desc = 'disable arrow' })
utils.keymap('n', '<Right>', '<Nop>', { desc = 'disable arrow' })

-- first last
utils.keymap('n', 'H', '^', { desc = 'move to first' })
utils.keymap('n', 'L', '$', { desc = 'move to last' })
utils.keymap('o', 'H', '^', { desc = 'move to first' })
utils.keymap('o', 'L', '$', { desc = 'move to last' })
utils.keymap('v', 'H', '^', { desc = 'move to first' })
utils.keymap('v', 'L', '$', { desc = 'move to last' })

-- nohilight
utils.keymap('n', '<C-h>', ':noh<cr>', { desc = 'nohilight' })
utils.keymap('n', '<BS>', ':noh<cr>', { desc = 'nohilight' })

-- etc...
utils.keymap('c', '%%', "getcmdtype()==':'?expand('%:h').'/': '%%'", { desc = 'expand parent directory' })
utils.keymap('s', 'w!!', 'w !sudo tee > /dev/null %<CR> :e!<CR', { desc = 'write as sudo' })

-- terminal
utils.keymap('t', '<Esc>', '<C-\\><C-n>', { desc = 'exit terminal' })
utils.keymap('t', '<C-[>', '<C-\\><C-n>', { desc = 'exit terminal' })
vim.cmd [[
  autocmd TermOpen * startinsert
]]

-- add escape for us keyboard
utils.keymap('t', '<C-]>', '<C-\\><C-n>', { desc = 'exit terminal' })
utils.keymap('n', '<C-]>', '<Esc>', { desc = 'exit terminal' })
utils.keymap('i', '<C-]>', '<Esc>', { desc = 'exit terminal' })
utils.keymap('v', '<C-]>', '<Esc>', { desc = 'exit terminal' })
