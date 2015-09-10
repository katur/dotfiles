" katherine's vim settings

""""""""""""
" Pathogen "
""""""""""""
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()


""""""""""""""""
" Autocommands "
""""""""""""""""
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


""""""""""""""""""
" Column 80 Club "
""""""""""""""""""
" Highlight column 80, dark gray (subtle on black background)
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Define text width limit
set textwidth=79

" Auto-wrap text and comments on textwidth
set formatoptions+=tc


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


"""""""""""""""""""
" File navigation "
"""""""""""""""""""
" Ignore compiled files
set wildignore+=*.o,*.class,*.rbc,*.pyc,*.swp,*.un~,*.obj

" Ignore version control directories
set wildignore+=.svn,.git

" Ignore temp/cached files
set wildignore+=vendor/gems/*,*/tmp/cache/*,CACHE/*,*/CACHE/*

" Ignore backups
set wildignore+=backups
