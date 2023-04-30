" Customize global settings
call ddc#custom#patch_global({
    \ 'ui': 'pum',
    \ 'sources': ['nvim-lsp', 'around', 'rg', 'file'],
    \ 'cmdlineSources': {
    \   ':': ['cmdline','cmdline-history', 'file', 'around'],
    \ },
    \ 'autoCompleteEvents': [
    \   'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged', 'CmdlineEnter'
    \ ],
    \ 'sourceOptions': #{
    \   _: #{
    \     matchers: ['matcher_fuzzy'],
    \     sorters: ['sorter_fuzzy'],
    \     converters: ['converter_fuzzy']
    \   },
    \   nvim-lsp: #{
    \     ignoreCase: v:true,
    \     mark: 'lsp',
    \     forceCompletionPattern: '\.\w*|:\w*|->\w*' 
    \   },
    \   around: #{
    \     mark:'a',
    \     ignoreCase: v:true 
    \   },
    \   rg: #{
    \     mark:'rg',
    \     ignoreCase: v:true 
    \   },
    \   cmdline: #{
    \     mark:'cmd',
    \     ignoreCase: v:true 
    \   },
    \   cmdline-history: #{
    \     mark:'hist',
    \     ignoreCase: v:true 
    \   },
    \   file: #{
    \     mark:'file',
    \     ignoreCase: v:true 
    \   },
    \ },
    \ 'sourceParams' : #{
    \   around: #{ maxSize: 500 },
    \ },
    \ 'uiParams': #{
    \   pum: #{ insert: v:false },
    \ },
    \ })

call ddc#enable()

