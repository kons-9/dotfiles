vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'ucs-boms,utf-8,euc-jp,cp932'
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.ambiwidth = 'single'

if vim.g.vscode then
    -- must have nvim
    require('utils')
    require('keymapping')
    require('env/vscode')
else
    require('utils')
    require('abbreviation')
    require('options')
    require('keymapping')
    require('lazydir')
    require('colors')
end
