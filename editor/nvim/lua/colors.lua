-- all
vim.cmd([[set t_Co=256]])
vim.cmd([[syntax enable]])
vim.cmd([[autocmd ColorScheme * highlight Normal      ctermbg=NONE guibg=NONE]])
vim.cmd([[autocmd ColorScheme * highlight NonText     ctermbg=NONE guibg=NONE]])
vim.cmd([[autocmd ColorScheme * highlight SpecialKey  ctermbg=NONE guibg=NONE]])
vim.cmd([[autocmd ColorScheme * highlight EndOfBuffer ctermbg=NONE guibg=NONE]])

-- iceberg

vim.cmd([[autocmd ColorScheme iceberg highlight LineNr      ctermbg=NONE ctermfg=241 guibg=NONE guifg=#444b71]])
vim.cmd([[autocmd ColorScheme iceberg highlight Visual      ctermbg=238 ctermfg=NONE guibg=#272c42 guifg=NONE]])
vim.cmd([[autocmd ColorScheme iceberg highlight CursorLineNr cterm=NONE ctermbg=239 ctermfg=253 guibg=#2a3158 guifg=#cdd1e6]])

-- gruvbox

vim.cmd([[autocmd ColorScheme gruvbox highlight LineNr      ctermbg=NONE ctermfg=241 guibg=NONE guifg=#444b71]])
vim.cmd([[autocmd ColorScheme gruvbox highlight Visual      ctermbg=240 ctermfg=NONE guibg=#272c42 guifg=NONE]])
vim.cmd([[autocmd ColorScheme gruvbox highlight CursorLineNr cterm=NONE ctermbg=239 ctermfg=253 guibg=#2a3158 guifg=#cdd1e6]])
vim.cmd([[autocmd ColorScheme gruvbox highlight EndOfBuffer      ctermfg=233 ctermbg=NONE guibg=NONE]])

-- colorscheme
-- vim.cmd [[colorscheme molokai]]
-- vim.cmd [[colorscheme hybrid]]
-- vim.cmd.colorscheme("iceberg")
vim.cmd.colorscheme("gruvbox")
vim.g.gruvbox_invert_selection = 0
vim.g.gruvbox_transparent_bg = 1
vim.g.gruvbox_contrast_dark = 'soft'
vim.g.gruvbox_bold = 0
vim.g.gruvbox_hls_cursor = 'none'
