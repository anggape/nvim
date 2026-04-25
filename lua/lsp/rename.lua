local Rename = {
  method = vim.lsp.protocol.Methods.textDocument_rename,
}

--- @param client vim.lsp.Client
--- @param buf integer
function Rename:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  Map.ni('<M-r>', vim.lsp.buf.rename, { buffer = buf })
end

return Rename
