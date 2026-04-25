local Formatting = {
  method = vim.lsp.protocol.Methods.textDocument_formatting,
  formatters = {},
  default_formatters = {},
}

function Formatting._format()
  local self = Formatting
  local ft = vim.bo.filetype

  if self.default_formatters[ft] then
    return vim.lsp.buf.format({
      name = self.default_formatters[ft],
    })
  end

  vim.ui.select(vim.tbl_keys(self.formatters[ft]), {
    prompt = 'select formatter: ',
  }, function(item)
    self.default_formatters[ft] = item
    return self._format()
  end)
end

--- @param client vim.lsp.Client
--- @param buf integer
function Formatting:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  if client:supports_method(self.method) then
    local ft = vim.bo[buf].filetype

    self.formatters[ft] = self.formatters[ft] or {}
    self.formatters[ft][client.name] = true

    Map.ni('<M-i>', self._format, { buffer = buf })
  end
end

return Formatting
