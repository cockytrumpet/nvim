-- "gc" to comment visual regions/lines
local M = {
  'numToStr/Comment.nvim',
  event = 'BufRead',
  opts = {},
  config = function()
    vim.keymap.set('n', '<leader>/', function()
      require('Comment.api').toggle.linewise.current()
    end, { desc = 'Toggle comment' })

    vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Toggle comment' })
  end,
}

return M
