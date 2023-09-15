local M = {}

function M.keymap(mode, key, result, opts, lazy_nvim)
    local desc = opts.desc
    opts.desc = nil

    if opts == nil or #opts == 0 then
        opts = {
            silent = true,
            nowait = false,
            expr = false,
            noremap = true,
        }
    end

    if desc == nil then
        desc = true
    end

    opts.desc = desc

    if lazy_nvim == nil then
        vim.keymap.set(mode, key, result, opts)
    end

    -- return is for lazy.nvim
    return { key, result, opts, mode = mode }
end

-- args contains augroup and autocmds
function M.make_autocmds(args)
    if args.augroup then
        vim.api.nvim_create_augroup(args.augroup, { clear = true })
    end
    for _, v in ipairs(args.autocmds) do
        local event = v.event
        local opts = v.opts

        if args.augroup then
            opts.group = args.augroup
        end
        vim.api.nvim_create_autocmd(event, opts)
    end
end

function M.safe_require(module, callback)
    local ok, safe_module = pcall(require, module)
    if ok then
        if callback then
            callback(safe_module)
        end
    else
        print("Error loading module " .. module)
    end
    return ok, safe_module
end

_G["utils"] = M
_G["g"] = vim.g

-- leader
g.mapleader = ' '

vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'ucs-boms,utf-8,euc-jp,cp932'
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.ambiwidth = 'single'

-- buflist setting
utils.keymap('n', '[b', ':bprevious<CR>', { desc = 'previous buffer' })
utils.keymap('n', ']b', ':bnext<CR>', { desc = 'next buffer' })
utils.keymap('n', '[B', ':bfirst<CR>', { desc = 'first buffer' })
utils.keymap('n', ']B', ':blast<CR>', { desc = 'last buffer' })

-- carsor movement
utils.keymap('n', 'j', 'gj', { desc = 'move down' })
utils.keymap('n', 'k', 'gk', { desc = 'move up' })
utils.keymap('n', '<down>', 'gj', { desc = 'move down' })
utils.keymap('n', '<up>', 'gk', { desc = 'move up' })

-- command history setting
utils.keymap('c', '<C-p>', '<Up>', { desc = 'command history up' })
utils.keymap('c', '<C-n>', '<Down>', { desc = 'command history down' })
-- vim.cmd [[set esckeys]]
utils.keymap('c', '<C-J>', '<C-n>', { desc = 'command history down' })
utils.keymap('c', '<C-K>', '<C-p>', { desc = 'command history up' })

-- disable arrow
utils.keymap('n', '<Up>', 'H', { desc = 'move to first' })
utils.keymap('n', '<Down>', 'L', { desc = 'move to last' })
utils.keymap('n', '<Left>', '<Nop>', { desc = 'disable arrow' })
utils.keymap('n', '<Right>', '<Nop>', { desc = 'disable arrow' })

-- first last
utils.keymap('n', 'H', '^', { desc = 'move to first' })
utils.keymap('n', 'L', '$', { desc = 'move to last' })
utils.keymap('o', 'H', '^', { desc = 'move to first' })
utils.keymap('o', 'L', '$', { desc = 'move to last' })
utils.keymap('v', 'H', '^', { desc = 'move to first' })
utils.keymap('v', 'L', '$', { desc = 'move to last' })

-- nohilight
utils.keymap('n', '<C-h>', ':noh<cr>', { desc = 'nohilight' })
utils.keymap('n', '<BS>', ':noh<cr>', { desc = 'nohilight' })

-- etc...
utils.keymap('c', '%%', "getcmdtype()==':'?expand('%:h').'/': '%%'", { desc = 'expand parent directory' })
utils.keymap('s', 'w!!', 'w !sudo tee > /dev/null %<CR> :e!<CR', { desc = 'write as sudo' })

-- terminal
utils.keymap('t', '<Esc>', '<C-\\><C-n>', { desc = 'exit terminal' })
utils.keymap('t', '<C-[>', '<C-\\><C-n>', { desc = 'exit terminal' })
vim.cmd [[
  autocmd TermOpen * startinsert
]]

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
            event = "BufEnter,FocusGained,InsertLeave,WinEnter",
            opts = {
                pattern = "*",
                command = 'if &nu && mode() != "i" | set rnu   | endif',
            },
        },
        {
            event = "BufLeave,FocusLost,InsertEnter,WinLeave",
            opts = {
                pattern = "*",
                command = "if &nu | set nornu | endif",
            },
        },
    },
})

vim.opt.cursorline = true
vim.opt.completeopt = 'menu,menuone'
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
                pattern = "markdown,text,gitcommit",
                command = "setlocal spell spelllang=en,cjk",
            },
        },
    },
})
