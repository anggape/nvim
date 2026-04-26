--- @type vim.lsp.Config
return {
  cmd = { 'stylua', '--lsp' },
  filetypes = { 'lua' },
  root_markers = {
    { '.stylua.toml', 'stylua.toml' },
    { '.git' },
  },
  preferred = {
    vim.lsp.protocol.Methods.textDocument_formatting,
  },
}
