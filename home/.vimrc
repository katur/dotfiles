" katherine's vim settings


set clipboard=unnamed


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

" Show line numbers on left of screen
set number

" Enable command line completion
set wildmenu
set wildmode=list:longest,full

" Enable code folding
set foldmethod=indent

" Set foldlevel very high so that all folds are open by default
set foldlevel=99


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
" Column 80 Club "
""""""""""""""""""

" Highlight column 80, dark gray (subtle on black background)
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Define text width limit
set textwidth=79

" Auto-wrap text and comments on textwidth
set formatoptions+=tc


""""""""""""""""""
" Searching text "
""""""""""""""""""

" Highlight search results
set hlsearch

" Ignore case while searching
set ignorecase

" Be smart about case while searching
set smartcase


""""""""""""""""""
" In/Out-denting "
""""""""""""""""""

" Keep visual selection while in/out-denting
vmap > >gv
vmap < <gv


"""""""""""""""""""
" File navigation "
"""""""""""""""""""

" Ignore compiled files (e.g. in tab completion, ctrlp)
set wildignore+=*.o,*.class,*.rbc,*.pyc

" Ignore version control directories
set wildignore+=.git,.svn,.hg

" Ignore temp/cached files
set wildignore+=*.swp,*.un~,vendor/gems/*,*/tmp/cache/*,CACHE/*,*/CACHE/*

" Ignore backups and raw materials
set wildignore+=backups,materials

" Ignore Node.js modules
set wildignore+=node_modules

" Shortcut to jump between split panes
" NOTE: 'nore' means not recursive
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
inoremap <C-h> <esc><C-w>h
inoremap <C-j> <esc><C-w>j
inoremap <C-k> <esc><C-w>k
inoremap <C-l> <esc><C-w>l


"""""""""""""
" Syntastic "
"""""""""""""

" Recommended beginner settings from
" https://github.com/scrooloose/syntastic#3-recommended-settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_python_exec = '/usr/local/bin/python'
