" ============================================================================
" File:        synonyms.vim
" Description: vim plugin find synonyms
" Maintainer:  Omar Sanhaji <sanhaji.omar@gmail.com>
" License:     GPLv2+.
" Notes:        
" ============================================================================


" Startup Check
"
" Has this plugin already been loaded? {{{
if &cp || exists('loaded_synonyms_vim')
  finish
endif

if !exists('g:synonyms_size')
  let g:synonyms_size = 30
endif

if !exists('g:synonyms_position')
  let g:synonyms_position = 'right'
endif

" TODO: What is better set it by default to &hidden or 1
if !exists('g:synonyms_autohide')
  let g:synonyms_autohide = &hidden
endif

let loaded_synonyms_vim = 1

command! -nargs=1 -range Synonyms call synonyms#synonyms(<f-args>)
command! -nargs=0 -range SynonymsSelection call synonyms#selection()
