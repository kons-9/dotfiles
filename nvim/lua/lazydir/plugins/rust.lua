local spec = {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      local _, null_ls = utils.safe_require("null-ls")
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates"
        },
      }
      utils.make_autocmds({
        augroup = "Crates",
        autocmds = {
          event = "BufRead",
          opts = {
            pattern = "Cargo.toml",
            callback = function()
              local _, cmp = utils.safe_require("cmp")
              cmp.setup.buffer({ sources = { { name = "crates" } } })
            end,
          }
        },
      })
    end,
  }

}
return spec
