------------- dein.vim ------------------
local home
local toml_dir
if vim.fn.has('win32') == 1 then
  home = os.getenv("MYVIMRC") .. "/../.."
  toml_dir = home .. '/nvim/lua/dein/toml'
else
  home = os.getenv("HOME")
  toml_dir = home .. '/.config/nvim/lua/dein/toml'
end

local dein_dir = home .. '/.cache/nvim/dein'
local dein_source = dein_dir .. '/repos/github.com/Shougo/dein.vim'

vim.cmd [[set rtp+=~/.cache/nvim/dein/repos/github.com/morhetz/gruvbox]]

vim.api.nvim_set_var('dein#install_github_api_token', os.getenv('DEINGITTOKEN'))

if vim.fn.isdirectory(dein_dir) == 0 then
  vim.cmd([[execute '!git clone https://github.com/Shougo/dein.vim ]] .. dein_source .. "'")
end

vim.o.runtimepath = dein_source .. ',' .. vim.o.runtimepath

if vim.call('dein#load_state', dein_dir) == 1 then
  vim.call('dein#begin', dein_dir)

  -- Let dein manage dein
  local toml = toml_dir .. '/dein.toml'
  local lazy_toml = toml_dir .. '/dein_lazy.toml'
  local tree_toml = toml_dir .. '/dein_tree.toml'
  local lsp_toml = toml_dir .. '/dein_lsp.toml'
  local insert_toml = toml_dir .. '/dein_insert.toml'
  -- local telescope_toml = toml_dir .. '/dein_telescope.toml'
  local depends_toml = toml_dir .. '/dein_depends.toml'
  local ddc_toml = toml_dir .. '/dein_ddc.toml'
  local ddu_toml = toml_dir .. '/dein_ddu.toml'
  local debug_toml = toml_dir .. '/dein_debug.toml'

  vim.call('dein#load_toml', depends_toml, { lazy = 0 })
  vim.call('dein#load_toml', toml, { lazy = 0 })
  vim.call('dein#load_toml', lsp_toml, { lazy = 0 })
  vim.call('dein#load_toml', ddu_toml, { lazy = 0 })
  vim.call('dein#load_toml', ddc_toml, { lazy = 0 })
  vim.call('dein#load_toml', debug_toml, { lazy = 0 })

  vim.call('dein#load_toml', lazy_toml, { lazy = 1 })
  vim.call('dein#load_toml', tree_toml, { lazy = 1 })
  vim.call('dein#load_toml', insert_toml, { lazy = 1 })

  vim.call('dein#end')
  vim.call('dein#save_state')

  -- Required:
end

-- If you want to install not installed plugins on startup.
if vim.call('dein#check_install') == 1 then
  vim.call('dein#install')
end

vim.call('dein#call_hook', 'source')

vim.cmd [[
 filetype plugin indent on
 syntax enable
]]
