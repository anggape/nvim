local Buf = {}

function Buf.get_vsel()
  return vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'))
end

return Buf
