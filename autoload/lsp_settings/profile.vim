function! lsp_settings#profile#load_local() abort
  try
    let l:root = lsp#utils#find_nearest_parent_directory('.', '.vim-lsp-settings')
    if !empty(l:root) && filereadable(l:root . '/settings.json')
      let l:settings = json_decode(join(readfile(l:root . '/settings.json'), "\n"))
      if  has_key(g:, 'lsp_settings')
        call lsp_settings#utils#merge(g:lsp_settings, l:settings)
      else
        let g:lsp_settings = l:settings
      endif
    endif
  catch
  endtry
endfunction

function! lsp_settings#profile#edit_local() abort
  let l:root = lsp_settings#root_path(['.vim-lsp-settings'])
  if !isdirectory(l:root)
    return
  endif
  let l:root .= '/.vim-lsp-settings'
  if !isdirectory(l:root)
    call mkdir(l:root)
  endif
  exe 'new' l:root . '/settings.json'
  if !filereadable(l:root . '/settings.json')
    call setline(1, ['{', "\t", '}'])
    call cursor([2, 2])
    setlocal nomodified
  endif
endfunction

let s:color_map = {
\ 'exited': 'Error',
\ 'starting': 'MoreMsg',
\ 'failed': 'WarningMsg',
\ 'running': 'Keyword',
\ 'not running': 'NonText'
\}

function! lsp_settings#profile#status() abort
  let l:settings = lsp_settings#settings()
  let l:active_servers = lsp#get_whitelisted_servers()
  for l:ft in keys(l:settings)
    let l:servers = l:settings[l:ft]
    for l:v in l:servers
      if index(l:active_servers, l:v.command) != -1
        let l:status = lsp#get_server_status(l:v.command)
        echon l:v.command . ': '
        exec 'echohl' s:color_map[l:status]
        echon l:status
        echohl None
      elseif lsp_settings#executable(l:v.command)
        echon l:v.command . ': '
        echohl vimFilter
        echon 'not running'
        echohl None
      else
        echon l:v.command . ': '
        echohl vimOption
        echon 'not installed'
        echohl None
      endif
      echo ''
    endfor
  endfor
endfunction
