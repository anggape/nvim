--- @type vim.lsp.Config
return {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp' },
  root_markers = {
    { '.clangd', '.clang-tidy', '.clang-format' },
    { 'compile_commands.json', 'compile_flags.txt' },
    '.git',
  },
}
