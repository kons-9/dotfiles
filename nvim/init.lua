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
  require('abbreviation')
  require('options')
  require('dein')
  -- require('neotree')
  require('statusline')
  require('keymapping')
  require('nvimlsp')
end

if vim.fn.has('mac') == 1 then
  require('mac')
end
