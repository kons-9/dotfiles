-- rustfmt
local spec = {
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies={
      {'nvim-lua/plenary.nvim'},
    },
    config = function ()
      local null_ls = require('null-ls')
      local sources = {
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.dart_format,
        null_ls.builtins.formatting.clang_format,
      }

      null_ls.setup({
        sources = sources,
      })
    end,


  }
}
return spec
