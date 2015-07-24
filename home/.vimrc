if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  " Auto-reload Vim configuration
  autocmd! BufWritePost .vimrc source ~/.vimrc

  " Enable autosave
  autocmd FocusLost * silent! wa

  " Remove trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e
endif
