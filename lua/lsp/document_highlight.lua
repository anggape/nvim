local DocumentHighlight = {
  method = vim.lsp.protocol.Methods.textDocument_documentHighlight,
  hlgroup = vim.api.nvim_create_augroup('ape-lsp-highlight', {
    clear = false,
  }),
}

--- @param client vim.lsp.Client
--- @param buf integer
function DocumentHighlight:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = buf,
    group = self.hlgroup,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = buf,
    group = self.hlgroup,
    callback = vim.lsp.buf.clear_references,
  })
end

--- @param client vim.lsp.Client
--- @param buf integer
function DocumentHighlight:on_detach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  vim.lsp.buf.clear_references()
  vim.api.nvim_clear_autocmds({
    group = self.hlgroup,
    buffer = buf,
  })
end

return DocumentHighlight
