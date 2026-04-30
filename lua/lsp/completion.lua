local kind = vim.lsp.protocol.CompletionItemKind
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
  kinds = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
  },
}

function Completion._ellipsis(str, max_len)
  local suffix = '...'
  if #str <= max_len then
    return str
  end
  if max_len <= #suffix then
    return suffix:sub(1, max_len)
  end
  return str:sub(1, max_len - #suffix) .. suffix
end

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
    convert = function(item)
      local label = string.format(
        '%s%s',
        item.label,
        vim.tbl_get(item, 'labelDetails', 'detail') or ''
      )
      return {
        abbr_hlgroup = 'LspKind' .. kind[item.kind],
        abbr = self.kinds[kind[item.kind]],
        kind = self._ellipsis(label, 30),
        menu = client.name,
      }
    end,
  })
end

return Completion
