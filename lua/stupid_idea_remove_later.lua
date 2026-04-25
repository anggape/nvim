--- @diagnostic disable: duplicate-set-field

-- NOTE:
--  i can't figure out how to configure completion popup window border,
--  so i do this since its the method that used to display that window.
local _complete_set = vim.api.nvim__complete_set
vim.api.nvim__complete_set = function(...)
  local result = _complete_set(...)
  if vim.api.nvim_win_is_valid(result.winid) then
    vim.api.nvim_win_set_config(result.winid, {
      border = vim.o.winborder,
    })
  end
  return result
end
