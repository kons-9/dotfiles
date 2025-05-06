local spec = {
  {
    "github/copilot.vim",
    -- event = "",
    config = function()
      vim.cmd [[
        let g:copilot_filetypes = {
          \ '*': v:true,
          \ }
      ]]
    end
  }
}

return spec
