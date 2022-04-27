local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerSync',
    group = packer_group,
    pattern = 'plugins.lua'
})

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
end)
