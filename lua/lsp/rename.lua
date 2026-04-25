local Rename = {
  method = vim.lsp.protocol.Methods.textDocument_rename,
}

--- @param client vim.lsp.Client
--- @param buf integer
function Rename:on_attach(client, buf)
  if not client:supports_method(self.method) then
    return
  end

  Map:with({ buffer = buf }, function()
    Map.ni('<M-r>', vim.lsp.buf.rename)
    Map.v('<M-r>', function()
      vim.ui.input({
        prompt = 'New Name: ',
        default = Buf.get_vsel()[1],
      }, function(input)
        _ = input and vim.lsp.buf.rename(input)
      end)
    end)
    Map.v('<M-R>', function()
      vim.lsp.buf.rename(Buf.get_vsel()[1])
    end)
  end)
end

return Rename
