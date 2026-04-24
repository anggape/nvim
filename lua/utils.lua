local Map = {
  opts_stack = {},
}
setmetatable(Map, Map)

function Map:__call(modes, lhs, rhs, opts)
  self:with(opts, function()
    vim.keymap.set(
      modes,
      lhs,
      rhs,
      vim.tbl_deep_extend('force', {}, {}, unpack(self.opts_stack))
    )
  end)
end

function Map:__index(key)
  local modes = vim.split(key, '')
  return function(lhs, rhs, opts)
    return self(modes, lhs, rhs, opts)
  end
end

function Map:with(opts, callback)
  local idx = #self.opts_stack + 1
  self.opts_stack[idx] = opts or {}
  callback()
  self.opts_stack[idx] = nil
end

_G.Map = Map
