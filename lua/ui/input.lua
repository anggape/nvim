-- TODO:
--   figure out how to disable adding/removing newline,
--   currently i can just use o/O insert mode.

local Input = {}
setmetatable(Input, Input)

--- @param opts? vim.ui.input.Opts
--- @param on_confirm fun(input?: string)
function Input:__call(opts, on_confirm)
  opts = opts or {}
  local prompt = opts.prompt or ''
  local default = opts.default or ''
  local width = math.max(25, #prompt, #default) + 5

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'cursor',
    style = 'minimal',
    row = -3,
    col = 1,
    width = width,
    height = 1,
    title = vim.trim(prompt),
  })

  vim.wo[win].winfixbuf = true

  vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, { default })
  vim.api.nvim_win_call(win, function()
    vim.cmd.startinsert({ bang = true })
  end)

  local function close(result)
    _ = vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_close(win, true)
    vim.cmd.stopinsert()
    on_confirm(result)
  end

  Map:with({ buffer = buf }, function()
    Map.n('<Esc>', close)
    Map.ni('<CR>', function()
      local row, _ = unpack(vim.api.nvim_win_get_cursor(win))
      local result = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]
      close(result)
    end)
  end)
end

return Input
