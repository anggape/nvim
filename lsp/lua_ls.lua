--- @type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    { '.luarc.json', '.luarc.jsonc' },
    { '.stylua.toml', 'stylua.toml' },
    { '.git' },
  },
  settings = {
    Lua = {
      codeLens = { enable = true },
      hint = {
        enable = true,
        semicolon = 'Disable',
      },
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
}
