local spec = {
  {
    'folke/which-key.nvim',
    config = function()
      utils.safe_require('which-key', function(wk)
        wk.setup {}
        wk.register({
          ["<leader>"] = {
            g = {name = "LSP GoTo"},
            l = {name = "LSP etc"},
            w = {name = "LSP Workspace"},
            f = {
              name = "Fuzzy Finder('telescope')",
              f = { name = "File" },
              e = { name = "Edit" },
              s = { name = "Search" },
              m = { name = "Move" },
              c = { name = "Command" },
              l = { name = "Lsp" },
              g = { name = "Git" },
              x = { name = "etc" },
            },
            ['<leader>'] = {
              name = 'Frecquent use tool',
              f = { name = "FF File" },
              -- e = { name = "Edit" },
              -- s = { name = "Search" },
              -- m = { name = "Move" },
              -- c = { name = "Command" },
              l = { name = "FF Lsp" },
              -- g = { name = "Git" },
              -- x = { name = "etc" },
            }
          }
        })
      end)
    end,
  }
}

return spec
