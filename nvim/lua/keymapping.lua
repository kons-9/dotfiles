local function keymap(mode, l, r, opt)
  if (not opt) then
    opt = {
      silent = false,
      nowait = false,
      expr = false,
      noremap = true,
    }
  end
  vim.api.nvim_set_keymap(mode, l, r, opt)
end

local g = vim.g

-- leader
g.mapleader = ' '

-- buflist setting
keymap('n', '[b', ':bprevious<CR>', { noremap = true, silent = true })
keymap('n', ']b', ':bnext<CR>', { noremap = true, silent = true })
keymap('n', '[B', ':bfirst<CR>', { noremap = true, silent = true })
keymap('n', ']B', ':blast<CR>', { noremap = true, silent = true })

-- carsor movement
keymap('n', 'j', 'gj')
keymap('n', 'k', 'gk')
keymap('n', '<down>', 'gj')
keymap('n', '<up>', 'gk')

-- command history setting
keymap('c', '<C-p>', '<Up>')
keymap('c', '<C-n>', '<Down>')
-- vim.cmd [[set esckeys]]
keymap('c', '<C-J>', '<C-n>')
keymap('c', '<C-K>', '<C-p>')

-- disable arrow
keymap('n', '<Up>', 'H')
keymap('n', '<Down>', 'L')
keymap('n', '<Left>', '<Nop>')
keymap('n', '<Right>', '<Nop>')

-- first last
keymap('n', 'H', '^')
keymap('n', 'L', '$')
keymap('v', 'H', '^')
keymap('v', 'L', '$')

-- nohilight
-- keymap('n', '<C-h>', ':noh<cr>', { noremap = true, silent = true })
keymap('n', '<BS>', ':noh<cr>', { noremap = true, silent = true })

-- etc...
keymap('c', '%%', "getcmdtype()==':'?expand('%:h').'/': '%%'", { noremap = true, expr = true })
keymap('s', 'w!!', 'w !sudo tee > /dev/null %<CR> :e!<CR')

-- terminal
keymap('t', '<Esc>', '<C-\\><C-n>')
keymap('t', '<C-[>', '<C-\\><C-n>')
vim.cmd [[
  autocmd TermOpen * startinsert
]]
