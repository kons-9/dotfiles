return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
      })
      vim.keymap.set("n", "<C-t>", "<cmd>lua require('oil').open()<CR>", { desc = "Open oil" ,silent = true })
    end,
  },
}
