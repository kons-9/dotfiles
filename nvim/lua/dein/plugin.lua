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

-- [quickrun]
keymap('n', '<leader>rr', ':QuickRun<CR>', { noremap = true, silent = true })

-- [ToggleTerm]
keymap('n', '<C-`>', ':ToggleTerm size=20<CR>')
keymap('t', '<C-`>', '<C-\\><C-n>:ToggleTermToggleAll<CR>')

--
-- [telescope]
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

-- [crate]
--
-- require('crates').setup()
