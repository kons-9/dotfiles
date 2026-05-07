local M = {}

function M.keymap(mode, key, result, opts, lazy_nvim)
    opts = vim.tbl_extend("keep", opts or {}, {
        silent = true,
        nowait = false,
        expr = false,
        noremap = true,
    })

    if lazy_nvim == nil then
        vim.keymap.set(mode, key, result, opts)
    end

    -- return is for lazy.nvim
    return vim.tbl_extend("force", { key, result, mode = mode }, opts)
end

_G["utils"] = M
