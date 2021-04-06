" ============================================================================
" File:        synonyms.vim
" Description: vim plugin find synonyms
" Maintainer:  Omar Sanhaji <sanhaji.omar@gmail.com>
" License:     GPLv2+.
" Notes:
" ============================================================================


if exists('g:autoloaded_synonyms') || &cp
  finish
endif

if !exists('g:synonyms_cmd')
  let g:synonyms_cmd = 'synonyms'
endif

" Activate autohide on synonyms buffer
function! s:activate_autocmds(bufnr)
  if g:synonyms_autohide
    augroup SynonymsAutoHide
      autocmd!
      execute 'autocmd Winleave <buffer=' . a:bufnr . '> close'
    augroup END
  endif
endfunction "}}}

" Manage window options
function! s:window() "{{{
  let l:name = '__Synonyms_Results__'
  let l:position = g:synonyms_position == 'left' ? 'topleft' : 'botright'
  if bufwinnr(l:name) == -1
    "Open a new Split
    execute position . ' vs ' . l:name
    execute 'vertical resize '. g:synonyms_size
    call s:activate_autocmds(bufnr(l:name))
  else
    execute bufwinnr(l:name) . "wincmd w"
  endif
endfunction "}}}

" Open synonyms buffer
function! s:preview() "{{{
  call s:window()
  normal! gg"_dG
  setl buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap filetype=synonyms
  " sil exe '%!' . l:synonyms_over_cmd
endfunction "}}}

"Utils
"TODO: The two folowing functions are redundunt
function! s:get_selection()
  " get current selection as list of lines, preserving registers
  let [contents, type] = [getreg('"'), getregtype('"')]
  try
    execute 'normal! gvy'
    return split(getreg('"'), ' ')
  finally
    call setreg('"', contents, type)
  endtry
endfunction "}}}

function! <SID>get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

"TODO: Manage when the word is at the end of the sentence
function! <SID>replace_word() "{{{
  " Copy current word
  let l:words = split(getline("."))
  " Move to previous buffer

  if len(l:words) == 0
    return
  endif

  "TODO: to be tested although it is a suspicious hack
  execute "close"
  execute "wincmd p"

  " Delete the word
  let l:select_cursor = getpos("'<")
  call setpos('.', l:select_cursor)
  exec "normal! d".len(<SID>get_visual_selection())."l"

  if len(getline(".")) == getpos(".")[2] "At the end of the line
    exec "normal! i " . join(l:words, " ")
  else
    exec "normal! i" . join(l:words, " ")
  endif
endfunction "}}}

" public functions

" TODO: Add Enter binding to insert text in cursor
function! synonyms#synonyms(word) range "{{{
  let l:save_cursor = getpos('.')
  let l:results = systemlist(g:synonyms_cmd . ' ' . a:word)

  call s:preview()
  call append(0, l:results)
endfunction "}}}

function! synonyms#selection() range "{{{
  let l:save_cursor = getpos('.')
  let l:selection = s:get_selection()
  let l:results = systemlist(g:synonyms_cmd . ' "' . join(l:selection, " "). '"')

  call s:preview()
  call append(0, l:results)

  nnoremap <buffer> <CR>  :call <SID>replace_word()<CR>
endfunction "}}}

let g:autoloaded_synonyms = 1
