augroup vimlsp_settings_typescript_language_server
  au!
  LspRegisterServer {
      \ 'name': 'typescript-language-server',
      \ 'cmd': {server_info->lsp_settings#get('typescript-language-server', 'cmd', [lsp_settings#exec_path('typescript-language-server'), '--stdio', '--tsserver-path', lsp_settings#exec_path('tsserver')])},
      \ 'root_uri':{server_info->lsp_settings#get('typescript-language-server', 'root_uri', lsp_settings#root_uri(['.git/', 'package.json']))},
      \ 'initialization_options': lsp_settings#get('typescript-language-server', 'initialization_options', {"diagnostics": "true"}),
      \ 'whitelist': lsp_settings#get('typescript-language-server', 'whitelist', ['javascript', 'javascriptreact', 'typescript', 'typescriptreact']),
      \ 'blacklist': lsp_settings#get('typescript-language-server', 'blacklist', []),
      \ 'config': lsp_settings#get('typescript-language-server', 'config', {}),
      \ 'workspace_config': lsp_settings#get('typescript-language-server', 'workspace_config', {}),
      \ }
augroup END
