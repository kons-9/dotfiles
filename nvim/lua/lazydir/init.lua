pcall(function()
  local lazypath = vim.fn.stdpath("data") ..  "/.cache/nvim/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end)

require('lazy').setup({{import = "lazydir.plugins"}})

-- disable default plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
