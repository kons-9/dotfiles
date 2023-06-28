local spec = {
  {
    'akinsho/toggleterm.nvim',

    keys = {
      utils.keymap('n', '<C-`>', ':ToggleTerm size=20<CR>', {desc = 'Toggle terminal'}, true),
      utils.keymap('t', '<C-`>', '<C-\\><C-n>:ToggleTermToggleAll<CR>', {desc = 'Toggle all terminal'}, true)
    },
    config = function()
    end,
  }
}
return spec
