local Hover = {
  method = vim.lsp.protocol.Methods.textDocument_hover,
}

--- @param client vim.lsp.Client
--- @param buf integer
function Hover:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  Map.ni('<M-Space>', vim.lsp.buf.hover, { buffer = buf })
end

return Hover
