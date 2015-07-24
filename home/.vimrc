if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  " Auto-reload Vim configuration on save
  autocmd! BufWritePost .vimrc source ~/.vimrc

  " Enable autosave
  autocmd FocusLost * silent! wa

  " Remove trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e
endif


"""""""""""""""""
" Editing style "
"""""""""""""""""
" Figure out the type of files
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

" Indent of new line matches previous
set autoindent

" Cause left/right movements at start/end of line to jump to previous/next line
set whichwrap+=<,>,h,l,[,]

" Use colors that look nice on dark background
set background=dark

" No beeping or flashing on errors
set noerrorbells
set novisualbell

" Show current row/column at bottom right of screen
set ruler

" Show line numbers
set number


""""""""
" Tabs "
""""""""
" Set tab size
set tabstop=2

" Help backspace/delete interpret spaces as tabs
set softtabstop=2

" Set block indent/unindent size
set shiftwidth=2

" Convert tabs to spaces
set expandtab

" Make backspace behave like most other apps
set backspace=2
set backspace=eol,start,indent


""""""""""""""""""
" Searching text "
""""""""""""""""""
" Highlight search results
set hlsearch

" Ignore case while searching
set ignorecase

" Be smart about case while searching
set smartcase
