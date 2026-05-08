--- @type vim.lsp.Config
return {
  cmd = { 'clangd', '--header-insertion=never' },
  filetypes = { 'c', 'cpp' },
  root_markers = {
    { '.clangd', '.clang-tidy', '.clang-format' },
    { 'compile_commands.json', 'compile_flags.txt' },
    '.git',
  },
}
