vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'ucs-boms,utf-8,euc-jp,cp932'
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.ambiwidth = 'single'

if vim.g.vscode then
  -- must have nvim
  require('vscode')
else
  require('colors')
  require('options')
  require('abbreviation')
  require('dein')
  require('nvimlsp')
  require('neotree')
  require('statusline')
end
require('keymapping')

if vim.fn.has('mac') == 1 then
  require('mac')
end
