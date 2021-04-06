# Synonyms

## Rationale

Synonyms.vim is a frontend plugin that allows you to show synonyms in a vim split, it is meant to shorten the cycle of going to your browser look for a word and comeback to vim; Losing all the brilliant ideas that would have enlightened the world.

It comes from my need of finding the right word when writing my reports, readmes and technical documentation, no need to go back and forth to thesaurus.

I wrote it a year before publishing it, I would have liked to cite my inspiration and sources; I got inspired from [fzf.vim](https://github.com/junegunn/fzf.vim) and Steve Losh wonderful book: [Learn Vimscript The Hard Way](https://learnvimscriptthehardway.stevelosh.com/).

![synonyms screenshot showcase](/doc/synonyms-screenshot.png "screenshot")

## Installation

### Using [Vundle](https://github.com/VundleVim/Vundle.vim)

Installing synonyms cli that uses [wordnet](https://wordnet.princeton.edu/documentation/wn1wn), you can change the [synonyms command](#Cusomization)
```
$ wget https://gist.githubusercontent.com/Sanhajio/e150d6bc3c70ea3c97168c9c18952c39/raw/ab6a90a38a3d2d032f2645c79d45c9d8f5ceae28/synonyms
$ chmod +x synonyms
$ mv synonyms /usr/local/bin/synonyms
```

```vimscript
Plugin `sanhajio/synonyms.vim`
```

## Customization

synonyms.vim supports some customization with global option variables shown below.

```vimscript
" Change the synonyms backend
" defaults to synonyms
let g:synonyms_cmd = 'your_cmd'

" Change synonyms split size
" defaults to 30
let g:synonyms_size = <split_size>

" let synonyms buffer to be hidden
" defaults to &hidden
let g:synonyms_autohide = 1
```

### Commands

| Command | List  |
| --- | --- |
|:Synonyms [WORD]|Run the synonyms command and show it in the buffer|
|:SynonymsSelection|After selecting the word; running the command would show synonyms in the buffer|

You can map the SynonymsSelection for easier use, for example:

```vimscript
vnoremap <C-N> :SynonymsSelection<cr>
```
