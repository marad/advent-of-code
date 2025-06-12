vim.cmd("autocmd BufNewFile,BufRead *.chi setlocal filetype=rust")
--vim.cmd('nnoremap <C-R> :w<cr>:!tmux send-keys -t right C-c Enter "chi " % Enter<cr>')
--vim.cmd('nnoremap <C-R> :w<cr>:!tmux send-keys -t right C-c Enter "python3 " % Enter<cr>')
vim.cmd('nnoremap <C-r> :w<cr>:!fennel %<cr>')
