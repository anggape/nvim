local handlers = {
  require('lsp.completion'),
  require('lsp.document_highlight'),
  require('lsp.signature_help'),
  require('lsp.formatting'),
  require('lsp.hover'),
  require('lsp.definition'),
  require('lsp.code_action'),
  require('lsp.rename'),
}

vim.api.nvim_create_autocmd({ 'LspDetach', 'LspAttach' }, {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    for _, handler in pairs(handlers) do
      pcall(
        args.event == 'LspAttach' and handler.on_attach or handler.on_detach,
        handler,
        client,
        args.buf
      )
    end
  end,
})

--- @type table<string, string[]>
local servers = { all = {} }

for _, config in pairs(vim.lsp.get_configs()) do
  local filetypes = config.filetypes
  if not filetypes then
    table.insert(servers.all, config.name)
  else
    for _, filetype in pairs(filetypes) do
      servers[filetype] = servers[filetype] or {}
      table.insert(servers[filetype], config.name)
    end
  end
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local filetype = vim.bo[args.buf].filetype
    for _, server in pairs(servers[filetype] or {}) do
      if not vim.lsp.is_enabled(server) then
        vim.lsp.enable(server)
      end
    end
  end,
})
