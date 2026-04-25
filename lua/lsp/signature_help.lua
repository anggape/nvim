local SignatureHelp = {
  method = vim.lsp.protocol.Methods.textDocument_signatureHelp,
}

--- @param client vim.lsp.Client
--- @param buf integer
function SignatureHelp:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  vim.api.nvim_create_autocmd('InsertCharPre', {
    buffer = buf,
    callback = function()
      local char = vim.v.char
      if char ~= '(' and char ~= ',' then
        return
      end

      vim.schedule(function()
        vim.lsp.buf.signature_help({
          max_width = 60,
          max_height = 10,
          silent = true,
          focus = false,
        })
      end)
    end,
  })
end

return SignatureHelp
