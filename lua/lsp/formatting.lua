local Formatting = {
  method = vim.lsp.protocol.Methods.textDocument_formatting,
  formatters = {},
  default_formatters = {},
}

function Formatting._select_formatter(ft, format)
  local self = Formatting
  local default = self.default_formatters[ft]

  vim.ui.select(vim.tbl_keys(self.formatters[ft]), {
    prompt = string.format(
      'change default formatter%s: ',
      default and string.format(' (active: %s)', default) or ''
    ),
  }, function(item)
    if not item then
      return
    end

    self.default_formatters[ft] = item
    _ = format and self._format()
  end)
end

function Formatting._format()
  local self = Formatting
  local ft = vim.bo.filetype

  if self.default_formatters[ft] then
    return vim.lsp.buf.format({
      name = self.default_formatters[ft],
    })
  end

  self._select_formatter(ft, true)
end

--- @param client vim.lsp.Client
--- @param buf integer
function Formatting:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  local ft = vim.bo[buf].filetype

  vim.api.nvim_buf_create_user_command(buf, 'SelectFormatter', function()
    self._select_formatter(ft, false)
  end, {})

  self.formatters[ft] = self.formatters[ft] or {}
  self.formatters[ft][client.name] = true

  --- @diagnostic disable-next-line: undefined-field
  local preferred = client.config.preferred or {}
  if vim.list_contains(preferred, self.method) then
    self.default_formatters[ft] = client.name
  end

  Map.ni('<M-i>', self._format, { buffer = buf })
end

return Formatting
