return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  {
    "alvan/vim-closetag",
    event = "InsertEnter",
    config = function()
      vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*.js,*.ts,*.jsx,*.tsx,*.xml"
    end,
    ft = {"html", "javascript", "typescript", "javascriptreact", "typescriptreact", "xml", "xhtml", "phtml", "jsx", "tsx"},
  },
}
