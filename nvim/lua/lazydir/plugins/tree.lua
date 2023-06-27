return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<C-t>", '<cmd>lua require("oil").open()<CR>', desc = "Open oil.nvim", mode = "n"},
    }
  },
}
