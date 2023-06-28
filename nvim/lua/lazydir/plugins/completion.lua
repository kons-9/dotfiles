utils.keymap('n', ':', '<cmd>call CommandlinePre()<CR>', { desc = 'completion' })

local spec = {
  {
    "Shougo/ddc.vim",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/pum.vim",
      "Shougo/ddc-ui-pum",
      'Shougo/ddc-source-nvim-lsp',
      'Shougo/ddc-source-around',
      'Shougo/ddc-source-rg',
      'LumaKernel/ddc-source-file',
      'Shougo/ddc-source-cmdline',
      'Shougo/ddc-source-cmdline-history',

      -- filter and sorter and converter
      'tani/ddc-fuzzy',

      -- preview
      'matsui54/denops-popup-preview.vim',
      'matsui54/denops-signature_help',

    },
    event = { "InsertEnter" },
    config = function ()
      vim.cmd([[
      " Customize global settings
      call ddc#custom#patch_global({
          \ 'ui': 'pum',
          \ 'sources': ['nvim-lsp', 'file', 'around', 'rg'],
          \ 'cmdlineSources': {
          \   ':': ['cmdline','cmdline-history', 'file', 'around'],
          \   '/': ['rg','file', 'around'],
          \ },
          \ 'autoCompleteEvents': [
          \   'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged', 'CmdlineEnter',
          \ ],
          \ 'sourceOptions': #{
          \   _: #{
          \     matchers: ['matcher_fuzzy'],
          \     sorters: ['sorter_fuzzy'],
          \     converters: ['converter_fuzzy'],
          \     ignoreCase: v:true,
          \     isVolatile: v:true,
          \   },
          \   nvim-lsp: #{
          \     mark: 'lsp',
          \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
          \     minAutoCompleteLength: 1,
          \   },
          \   around: #{
          \     mark:'a',
          \   },
          \   rg: #{
          \     mark:'rg',
          \   },
          \   cmdline: #{
          \     mark:'cmd',
          \     minAutoCompleteLength: 1,
          \   },
          \   cmdline-history: #{
          \     mark:'hist',
          \   },
          \   file: #{
          \     mark:'file',
          \   },
          \ },
          \ 'sourceParams' : #{
          \   around: #{ maxSize: 500 },
          \ },
          \ 'uiParams': #{
          \   pum: #{ 
          \     insert: v:false,
          \   },
          \ },
          \ })

      call ddc#enable()

      ]])
    end

  },{
    "Shougo/pum.vim",
    dependencies = {
      "Shougo/ddc.vim",
    },
    config = function ()
      vim.cmd([[
        nnoremap :       <Cmd>call CommandlinePre()<CR>:
        inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
        inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
        inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
        inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
        inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
        inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>

        " pum settings of command line
        function! CommandlinePre() abort
            cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
            cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
            cnoremap <expr> <C-n> pum#visible() ? pum#map#insert_relative(+1) : '<Down>'
            cnoremap <expr> <C-p> pum#visible() ? pum#map#insert_relative(-1) : '<Up>'
            cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
            " cmap <expr><CR>   pum#visible() ? '<C-y>' : '<CR>'
            cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

            autocmd User DDCCmdlineLeave ++once call CommandlinePost()

            " Enable command line completion for the buffer
            call ddc#enable_cmdline_completion()
        endfunction

        function! CommandlinePost() abort
            silent! cunmap <Tab>
            silent! cunmap <S-Tab>
            silent! cunmap <C-n>
            silent! cunmap <C-p>
            silent! cunmap <C-y>
            silent! cunmap <CR>
            silent! cunmap <C-e>
        endfunction
      ]])
    end,
  }, {
    'matsui54/denops-popup-preview.vim',
    config = function ()
      vim.cmd([[
        call popup_preview#enable()
      ]])
    end
  }, {
    'matsui54/denops-signature_help',
    config = function ()
      vim.cmd([[
        call signature_help#enable()
      ]])
    end,

  }
}

return spec
