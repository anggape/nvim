vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')[1]
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark > 0 and mark <= line_count then
      vim.api.nvim_buf_call(args.buf, function()
        vim.cmd.normal({
          args = { 'g`"zz' },
          bang = true,
        })
      end)
    end
  end,
})

-- TODO: figure out why 'relativenumber' not doing anything when i have custom 'statuscolumn'.
local statuscolumn = vim.o.statuscolumn
vim.api.nvim_create_autocmd({ 'InsertEnter', 'InsertLeave' }, {
  callback = function(args)
    vim.opt.statuscolumn = args.event == 'InsertLeave' and statuscolumn or ''
    vim.opt.relativenumber = args.event == 'InsertLeave'
  end,
})
