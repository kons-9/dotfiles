-- help
vim.cmd([[autocmd FileType help wincmd L]])

vim.cmd([[
syntax on
filetype plugin indent on
]])

--window
vim.opt.splitright = true
-- buffer
vim.opt.hidden = true
vim.opt.autowrite = true

-- status line
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.ruler = false

-- commandmode
vim.opt.wildmenu = true
vim.opt.history = 5000

-- tab indent
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4

-- string
-- only capital letter
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- <C-h> setting
-- I use Karabiner-element and here, I change <C-h> to delete.
-- vim.opt.backspace = 'indent,eol,start'

-- (){} corresponding
vim.opt.showmatch = true
vim.opt.matchtime = 2

vim.opt.whichwrap = "b,s,h,l,<,>,[,],~"
vim.opt.relativenumber = true
vim.opt.number = true

utils.make_autocmds({
  augroup = "numbertoggle",
  autocmds = {
    {
      event = {"BufEnter","FocusGained","InsertLeave","WinEnter"},
      opts = {
        pattern = "*",
        command = 'if &nu && mode() != "i" | set rnu   | endif',
      },
    },
    {
      event = {"BufLeave","FocusLost","InsertEnter","WinLeave"},
      opts = {
        pattern = "*",
        command = "if &nu | set nornu | endif",
      },
    },
  },
})

vim.opt.cursorline = true
-- vim.opt.completeopt = 'menu,menuone'
-- vim.opt.completeopt = "popup"

vim.opt.wildcharm = ("\t"):byte()
vim.opt.wildchar = ("\t"):byte()
vim.opt.wildmode = "full"

-- spell checker
utils.make_autocmds({
  augroup = "spell",
  autocmds = {
    {
      event = "FileType",
      opts = {
        pattern = {"markdown","text","gitcommit"},
        command = "setlocal spell spelllang=en,cjk",
      },
    },
  },
})

utils.make_autocmds({
    augroup = "filetype",
    autocmds = {
        {
            event = {"BufNewFile","BufRead"},
            opts = {
                pattern = {"*.mak","*.mk","Makefile","makefile","Makefile.*","makefile.*"},
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    vim.api.nvim_buf_set_option(bufnr, "filetype", "make")
                end,
            },
        },
    },
})
