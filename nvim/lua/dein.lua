------------- dein.vim ------------------

local home = os.getenv("HOME")
local dein_dir = home .. '/.cache/nvim/dein'
local toml_dir = home .. '/.config/nvim/lua/toml'
local dein_source = dein_dir .. '/repos/github.com/Shougo/dein.vim'

if vim.fn.isdirectory(dein_dir) == 0 then
  os.execute('git clone https://github.com/Shougo/dein.vim ' .. dein_source)
end

vim.o.runtimepath = dein_source .. ',' .. vim.o.runtimepath

if vim.call('dein#load_state', dein_dir) == 1 then
  vim.call('dein#begin', dein_dir)

  -- Let dein manage dein
  local toml = toml_dir .. '/dein.toml'
  local lazy_toml = toml_dir .. '/dein_lazy.toml'

  vim.call('dein#load_toml', toml, { lazy = 0 })
  vim.call('dein#load_toml', lazy_toml, { lazy = 1 })

  vim.call('dein#end')
  vim.call('dein#save_state')

  -- Required:
  vim.cmd [[
       filetype plugin indent on
       syntax enable
     ]]
end

-- If you want to install not installed plugins on startup.
if vim.call('dein#check_install') == 1 then
  vim.call('dein#install')
end
