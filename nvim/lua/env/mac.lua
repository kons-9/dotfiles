if vim.fn.executable('im-select') == 1 then
  vim.cmd("autocmd InsertLeave * :call system('im-select com.apple.keylayout.ABC')")
  vim.cmd("autocmd CmdlineLeave * :call system('im-select com.apple.keylayout.ABC')")
end
