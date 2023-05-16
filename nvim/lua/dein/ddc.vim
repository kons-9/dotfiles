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

