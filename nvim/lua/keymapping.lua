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
keymap('n', 'M', ':noh<cr>', { noremap = true, silent = true })

-- etc...
keymap('c', '%%', "getcmdtype()==':'?expand('%:h').'/': '%%'", { noremap = true, expr = true })
keymap('s', 'w!!', 'w !sudo tee > /dev/null %<CR> :e!<CR')

-- terminal
keymap('n', '<C-`>', ':ToggleTerm size=20<CR>')
keymap('t', '<C-`>', '<C-\\><C-n>:ToggleTermToggleAll<CR>')
keymap('t', '<Esc>', '<C-\\><C-n>')
keymap('t', '<C-[>', '<C-\\><C-n>')
vim.cmd [[
  autocmd TermOpen * startinsert
]]

--
------------------------ plugins ----------------------
--
--[telescope]
--
require("telescope").load_extension "file_browser"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fe', ":Telescope file_browser<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fm', builtin.man_pages, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fc', builtin.commands, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ft', builtin.treesitter, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fq', builtin.quickfix, { noremap = true, silent = true })

local actions = require("telescope.actions")

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-e>"] = actions.close,
            },
        },
    },
})


-- vsnip
keymap('i', '<Tab>', 'gj')
keymap('n', 'k', 'gk')
keymap('i', '<Tab>', "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ", { expr = true, silent = true })
keymap('s', '<Tab>', "vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ", { expr = true, silent = true })
keymap('i', '<S-Tab>', "vsnip#jumpable(-1)   ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ",
    { expr = true, silent = true })
keymap('s', '<S-Tab>', "vsnip#jumpable(-1)   ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ",
    { expr = true, silent = true })
