local spec = {
  {
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function() require'alpha'.setup(require'alpha.themes.startify'.opts) end,
    -- opts = { require'alpha.themes.startify'.config }
  },

}
return spec
