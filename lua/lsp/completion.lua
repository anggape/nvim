local Completion = {
  method = vim.lsp.protocol.Methods.textDocument_completion,
  trigger_chars = vim.split(
    ' '
      .. 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
      .. 'abcdefghijklmnopqrstuvwxyz'
      .. '1234567890'
      .. '!$*+,-./:;=?^_`@<>{[',
    ''
  ),
}

--- @param client vim.lsp.Client
--- @param buf integer
function Completion:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  local provider = client.server_capabilities.completionProvider
  if provider then
    provider.triggerCharacters = self.trigger_chars
  end
  vim.lsp.completion.enable(true, client.id, buf, {
    autotrigger = true,
  })
end

return Completion
