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

local function smart_jump(lhs, direction)
  local function rhs()
    if vim.fn.pumvisible() == 1 then
      return string.format('<C-%s>', direction == 1 and 'n' or 'p')
    elseif vim.snippet.active({ direction = direction }) then
      return string.format('<Cmd>lua vim.snippet.jump(%d)<CR>', direction)
    end
    return lhs
  end
  return lhs, rhs
end

Map:with({ expr = true }, function()
  Map.i(smart_jump('<Tab>', 1))
  Map.i(smart_jump('<S-Tab>', -1))
  Map.i('<CR>', function()
    return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
  end)
end)
