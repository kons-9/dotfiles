return {
  {
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' } ,
    config = function()
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-e>'] = require('telescope.actions').close,
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>',desc = 'Find files', mode = 'n'},
      { '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', desc = 'Grep files', mode = 'n'},
      { '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>',   desc = 'Find buffers', mode = 'n'},
      { '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', desc = 'Find help tags', mode = 'n'},
    },
  },
}
