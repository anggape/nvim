vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.showmode = false
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.showcmdloc = 'statusline'
vim.opt.statuscolumn = '%s%=%{v:virtnum==0?(v:relnum?v:relnum:v:lnum):""} '
vim.opt.statusline = '%!v:lua.require("ui.statusline")()'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.winborder = 'single'
vim.opt.pumborder = 'single'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 999
vim.opt.laststatus = 3
vim.opt.shortmess:append('c')
vim.opt.fillchars:append('eob: ')
vim.opt.completeopt = {
  'menu',
  'menuone',
  'noinsert',
  'fuzzy',
  'popup',
}
vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
  trail = '•',
  extends = '⟩',
  precedes = '⟨',
  nbsp = '␣',
  lead = '·',
  space = '·',
  multispace = '•',
}

vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
})
