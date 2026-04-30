--- @diagnostic disable: duplicate-set-field

-- NOTE:
--  i can't figure out how to configure completion popup window border,
--  so i do this since its the method that used to display that window.
local _complete_set = vim.api.nvim__complete_set
vim.api.nvim__complete_set = function(...)
  local result = _complete_set(...)
  if result and result.winid and vim.api.nvim_win_is_valid(result.winid) then
    pcall(vim.api.nvim_win_set_config, result.winid, {
      border = vim.o.winborder,
    })
  end
  return result
end

-- NOTE:
--  another hack to fix popup window too wide after adding border.
vim.api.nvim_create_autocmd('CompleteChanged', {
  group = vim.api.nvim_create_augroup(
    'stupid_idea_remove_later-complete-changed',
    { clear = true }
  ),
  callback = function()
    local info = vim.fn.complete_info({ 'selected' })
    local win = info.preview_winid
    if not win or not vim.api.nvim_win_is_valid(win) then
      return
    end

    local width = vim.api.nvim_win_get_width(win)
    local pos = vim.api.nvim_win_get_position(win)
    local pum = vim.fn.pum_getpos()
    local pum_col = pum.col or 0
    local pum_width = pum.width or 0
    local is_too_wide = (pos[2] - (pum_col + pum_width)) < 2

    vim.api.nvim_win_set_config(win, {
      border = vim.o.winborder,
      width = is_too_wide and width - 2 or width,
    })
  end,
})
