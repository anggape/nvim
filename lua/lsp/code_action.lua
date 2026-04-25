local CodeAction = {
  method = vim.lsp.protocol.Methods.textDocument_codeAction,
}

--- @param client vim.lsp.Client
--- @param buf integer
function CodeAction:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  Map.ni('<M-.>', vim.lsp.buf.code_action, { buffer = buf })
end

return CodeAction
