augroup vimlsp_settings_slp
  au!
  LspRegisterServer {
      \ 'name': 'slp',
      \ 'cmd': {server_info->lsp_settings#get('slp', 'cmd', [lsp_settings#exec_path('slp.pl')])},
      \ 'root_uri':{server_info->lsp_settings#get('slp', 'root_uri', lsp_settings#root_uri())},
      \ 'initialization_options': lsp_settings#get('slp', 'initialization_options', v:null),
      \ 'whitelist': lsp_settings#get('slp', 'whitelist', ['perl']),
      \ 'blacklist': lsp_settings#get('slp', 'blacklist', []),
      \ 'config': lsp_settings#get('slp', 'config', lsp_settings#server_config('slp')),
      \ 'workspace_config': lsp_settings#get('slp', 'workspace_config', {}),
      \ }
augroup END
