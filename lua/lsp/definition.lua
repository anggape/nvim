local Definition = {
  method = vim.lsp.protocol.Methods.textDocument_definition,
}

--- @param client vim.lsp.Client
--- @param buf integer
function Definition:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  Map.ni('<M-g>', vim.lsp.buf.definition, { buffer = buf })
end

return Definition
