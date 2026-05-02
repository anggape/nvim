local mode_map = {
  ['n'] = 'NORMAL',
  ['no'] = 'O-PENDING',
  ['nov'] = 'O-PENDING',
  ['noV'] = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['nt'] = 'NORMAL',
  ['ntT'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'V-LINE',
  ['Vs'] = 'V-LINE',
  ['\22'] = 'V-BLOCK',
  ['\22s'] = 'V-BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'S-LINE',
  ['\19'] = 'S-BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rx'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rvc'] = 'V-REPLACE',
  ['Rvx'] = 'V-REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'EX',
  ['ce'] = 'EX',
  ['r'] = 'REPLACE',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

local function wrap_hl(hl, value)
  return '%#' .. hl .. '#' .. value .. '%#StatusLine#'
end

local function separator(char)
  return wrap_hl('NonText', ' ' .. (char or '╱') .. ' ')
end

return function()
  local mode = mode_map[vim.fn.mode()] or 'UNKNOWN'
  local mode_hl = '@ape.statusline.'
    .. (mode == 'INSERT' and 'mode_alt' or 'mode')

  local filetype = vim.bo.filetype == '' and '-' or vim.bo.filetype
  local fileformat = vim.bo.fileformat == '' and '-' or vim.bo.fileformat
  local fileencoding = vim.bo.fileencoding == '' and '-' or vim.bo.fileencoding

  return wrap_hl(mode_hl, ' ' .. mode .. ' ')
    .. ' '
    .. '%f %m'
    .. '%='
    .. '%#SpecialChar#%S%#StatusLine#'
    .. ' '
    .. filetype
    .. separator()
    .. fileencoding
    .. separator()
    .. fileformat
    .. separator()
    .. '%02l:%02c '
end
