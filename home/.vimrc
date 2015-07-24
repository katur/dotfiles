if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  " Auto-reload Vim configuration
  autocmd! BufWritePost .vimrc source ~/.vimrc

  " Enable autosave
  autocmd FocusLost * silent! wa

  " Remove trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e
endif


"""""""""""""""""
" Editing Style "
"""""""""""""""""
" Figure out the type of files
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

" Indent of new line matches previous
set autoindent

" Use colors that look nice on dark background
set background=dark

" No beeping or flashing on errors
set noerrorbells
set novisualbell

" Show current row/column at bottom right of screen
set ruler

" Show line numbers
set number
