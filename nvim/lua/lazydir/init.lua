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
