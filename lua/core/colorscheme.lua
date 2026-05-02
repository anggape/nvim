vim.cmd.colorscheme('catppuccin')

local colors = {
  rosewater = '#f5e0dc',
  flamingo = '#f2cdcd',
  pink = '#f5c2e7',
  mauve = '#cba6f7',
  red = '#f38ba8',
  maroon = '#eba0ac',
  peach = '#fab387',
  yellow = '#f9e2af',
  green = '#a6e3a1',
  teal = '#94e2d5',
  sky = '#89dceb',
  sapphire = '#74c7ec',
  blue = '#89b4fa',
  lavender = '#b4befe',
  text = '#cdd6f4',
  subtext1 = '#bac2de',
  subtext0 = '#a6adc8',
  overlay2 = '#9399b2',
  overlay1 = '#7f849c',
  overlay0 = '#6c7086',
  surface2 = '#585b70',
  surface1 = '#45475a',
  surface0 = '#313244',
  base = '#1e1e2e',
  mantle = '#181825',
  crust = '#11111b',
}

--- @type table<string, vim.api.keyset.highlight>
local kinds = {
  Text = { fg = colors.green },
  Method = { fg = colors.blue },
  Function = { fg = colors.blue },
  Constructor = { fg = colors.blue },
  Field = { fg = colors.green },
  Variable = { fg = colors.flamingo },
  Class = { fg = colors.yellow },
  Interface = { fg = colors.yellow },
  Module = { fg = colors.blue },
  Property = { fg = colors.blue },
  Unit = { fg = colors.green },
  Value = { fg = colors.peach },
  Enum = { fg = colors.yellow },
  Keyword = { fg = colors.mauve },
  Snippet = { fg = colors.flamingo },
  Color = { fg = colors.red },
  File = { fg = colors.blue },
  Reference = { fg = colors.red },
  Folder = { fg = colors.blue },
  EnumMember = { fg = colors.teal },
  Constant = { fg = colors.peach },
  Struct = { fg = colors.blue },
  Event = { fg = colors.blue },
  Operator = { fg = colors.sky },
  TypeParameter = { fg = colors.maroon },
}

--- @type table<string, vim.api.keyset.highlight>
local highlights = {
  FloatBorder = { link = 'NormalFloat' },
  FloatTitle = { link = 'NormalFloat' },
  CursorLineNr = { link = 'CursorLine' },
  NonText = { fg = colors.surface0 },
  SpecialChar = { fg = colors.surface2 },

  ['@ape.statusline.mode'] = {
    bg = colors.blue,
    fg = colors.crust,
    bold = true,
  },
  ['@ape.statusline.mode_alt'] = {
    bg = colors.yellow,
    fg = colors.crust,
    bold = true,
  },
}

for key, value in pairs(kinds) do
  highlights[key] = value
  highlights['LspKind' .. key] = { link = key }
end

for key, value in pairs(highlights) do
  vim.api.nvim_set_hl(0, key, value)
end
