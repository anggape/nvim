local formatters = {}
local default_formatters = {}
local trigger_chars = vim.split(
  ' '
    .. 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    .. 'abcdefghijklmnopqrstuvwxyz'
    .. '1234567890'
    .. '!$*+,-./:;=?^_`@<>{[',
  ''
)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local m = vim.lsp.protocol.Methods

    if client:supports_method(m.textDocument_completion) then
      local provider = client.server_capabilities.completionProvider
      if provider then
        provider.triggerCharacters = trigger_chars
      end
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
      })
    end

    if client:supports_method(m.textDocument_documentHighlight) then
      local hlgroup = vim.api.nvim_create_augroup('ape-lsp-highlight', {
        clear = false,
      })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = args.buf,
        group = hlgroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = args.buf,
        group = hlgroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup(
          'ape-lsp-highlight-detach',
          { clear = true }
        ),
        callback = function(args1)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = hlgroup,
            buffer = args1.buf,
          })
        end,
      })
    end

    Map:with({ buffer = args.buf }, function()
      if client:supports_method(m.textDocument_formatting) then
        local ft = vim.bo[args.buf].filetype

        formatters[ft] = formatters[ft] or {}
        formatters[ft][client.name] = true

        local function format()
          if default_formatters[ft] then
            return vim.lsp.buf.format({
              name = default_formatters[ft],
            })
          end

          vim.ui.select(vim.tbl_keys(formatters[ft]), {
            prompt = 'select formatter: ',
          }, function(item)
            default_formatters[ft] = item
            return format()
          end)
        end

        Map.ni('<M-i>', format)
      end

      if client:supports_method(m.textDocument_hover) then
        Map.ni('<M-Space>', vim.lsp.buf.hover)
      end

      if client:supports_method(m.textDocument_definition) then
        Map.ni('<M-g>', vim.lsp.buf.definition)
      end

      if client:supports_method(m.textDocument_codeAction) then
        Map.ni('<M-.>', vim.lsp.buf.code_action)
      end

      if client:supports_method(m.textDocument_rename) then
        Map.ni('<M-r>', vim.lsp.buf.rename)
      end
    end)
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
