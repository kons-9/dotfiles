-- Fnrn
--
local g = vim.g
local keymap = vim.api.nvim_set_keymap

keymap('n', '<c-t>', ':Fern . -right -drawer -toggle<cr>', { noremap = true, silent = true })
