--- @type vim.lsp.Config
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = {
    { 'go.mod', 'go.sum', 'go.work' },
    { '.git' },
  },
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
}
