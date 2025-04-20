local spec = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview" },
  build = "cd app && npm install",
  init = function() vim.g.mkdp_filetypes = { "markdown" } end,
  ft = { "markdown" },
  -- cmd = { "MarkdownPreview" },
}
return spec
