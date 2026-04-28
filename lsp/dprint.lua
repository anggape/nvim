--- @type vim.lsp.Config
return {
  cmd = { 'dprint', 'lsp' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'markdown',
    'python',
    'toml',
    'rust',
    'roslyn',
    'graphql',
  },
  root_markers = {
    {
      'dprint.json',
      'dprint.jsonc',
      '.dprint.json',
      '.dprint.jsonc',
    },
    { '.git' },
  },
  settings = {},
}
