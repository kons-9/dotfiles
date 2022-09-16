------------- dein.vim ------------------

local home = os.getenv("HOME")
local dein_dir = home .. '/.cache/nvim/dein'
local toml_dir = home .. '/.config/nvim/lua/toml'
local dein_source = dein_dir .. '/repos/github.com/Shougo/dein.vim'

vim.o.runtimepath = dein_source .. ',' .. vim.o.runtimepath

if vim.call('dein#load_state', dein_dir) == 1 then
     vim.call('dein#begin', dein_dir)
 
     -- Let dein manage dein
     local toml = toml_dir .. '/dein.toml'
     local lazy_toml = toml_dir .. '/dein_lazy.toml'
 
     vim.call('dein#load_toml', toml, {lazy = 0})
     vim.call('dein#load_toml', lazy_toml, {lazy = 1})

     vim.call('dein#end')
     vim.call('dein#save_state')
 
     -- Required:
     vim.cmd[[
       filetype plugin indent on
       syntax enable
     ]]
end

-- If you want to install not installed plugins on startup.
if vim.call('dein#check_install') == 1 then
  vim.call('dein#install')
end



------------- packer.nvim ----------------
-- local ensure_packer = function()
--   local fn = vim.fn
--   local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--   if fn.empty(fn.glob(install_path)) > 0 then
--     fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--     vim.cmd [[packadd packer.nvim]]
--     return true
--   end
--   return false
-- end
-- 
-- local packer_bootstrap = ensure_packer()
-- 
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])
-- 
-- return require('packer').startup(function(use)
--   -- Packer can manage itself
--   use 'wbthomason/packer.nvim'
--   use 'neovim/nvim-lspconfig'
--   use 'tpope/vim-commentary'
-- 
--   if packer_bootstrap then
--     require('packer').sync()
--   end
-- end)

