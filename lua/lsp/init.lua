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

for _, config in pairs(vim.lsp.get_configs()) do
  local executable = config.cmd[1]
  local name = config.name --[[@as string]]

  if vim.fn.executable(executable) == 1 then
    vim.lsp.enable(name)
  else
    vim.notify(
      string.format(
        "can't find '%s' executable! %s lsp will be disabled",
        executable,
        name
      ),
      vim.log.levels.WARN
    )
  end
end
