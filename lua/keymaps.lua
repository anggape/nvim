Map.n('<Esc>', vim.cmd.nohlsearch)

Map.n('-', vim.cmd.foldclose)
Map.n('=', vim.cmd.foldopen)

Map.n('<M-h>', '<C-w>h')
Map.n('<M-l>', '<C-w>l')
Map.n('<M-j>', '<C-w>j')
Map.n('<M-k>', '<C-w>k')

Map.ni('<M-w>', vim.cmd.bdelete)
Map.ni('<M-c>', vim.cmd.bnext)
Map.ni('<M-C>', vim.cmd.bprev)
Map.ni('<M-s>', vim.cmd.write)
