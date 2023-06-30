local spec = {
  {
    'akinsho/toggleterm.nvim',
    -- keys = {
    --   utils.keymap('n', '<C-`>', ':ToggleTerm size=20<CR>', {desc = 'Toggle terminal'}, true),
    --   utils.keymap('t', '<C-`>', '<C-\\><C-n>:ToggleTermToggleAll<CR>', {desc = 'Toggle all terminal'}, true)
    -- },
    config = function()
      -- utils.keymap('n', '<C-`>', ':ToggleTerm size=20<CR>', {desc = 'Toggle terminal'})
      vim.api.nvim_set_keymap('n', '<C-`>', ':ToggleTerm size=20<CR>', {desc = 'Toggle terminal', silent = false, noremap = true})
      utils.keymap('t', '<C-`>', '<C-\\><C-n>:ToggleTermToggleAll<CR>', {desc = 'Toggle all terminal'})
      -- utils.keymap('n', '<leader>t', '<cmd>ToggleTerm size=20<CR>', {desc = 'Toggle terminal'})
      -- utils.keymap('t', '<C-@>', '<C-\\><C-n>:ToggleTermToggleAll<CR>', {desc = 'Toggle all terminal'})
      
      require('toggleterm').setup{
      }
    end,
  }
}
return spec
