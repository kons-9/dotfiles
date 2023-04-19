vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'ucs-boms,utf-8,euc-jp,cp932'
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.ambiwidth = 'single'

if vim.g.vscode then
  -- must have nvim
  require('env/vscode')
else
  require('colors')
  require('abbreviation')
  require('options')
  require('keymapping')
  require('dein')
end

if vim.fn.has('mac') == 1 then
  require('env/mac')
elseif vim.fn.has('linux') then
  require('env/linux')
end

