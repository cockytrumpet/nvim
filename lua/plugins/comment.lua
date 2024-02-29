local M = {
  'numToStr/Comment.nvim',
  event = 'BufRead',
  opts = {
    {
      padding = true,
      sticky = true,
      ignore = nil,
      -- toggler = { line = 'gcc', block = 'gbc' },
      opleader = { line = 'gc', block = 'gb' },
      extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
      mappings = { basic = true, extra = true },
      pre_hook = nil,
      post_hook = nil,
    },
  },
  config = function(opts)
    vim.keymap.set('n', '<leader>/', function()
      require('Comment.api').toggle.linewise.current()
    end, { desc = 'toggle comment' })
    vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'toggle comment' })

    require('Comment').setup(opts)
  end,
}

return M
