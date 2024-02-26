local M = {
  'Wansmer/treesj',
  event = 'BufWinEnter',
  config = function()
    vim.keymap.set('n', '<leader>m', '<CMD>TSJToggle<CR>', { desc = 'Split/Join' })
    require('treesj').setup {
      use_default_keymaps = false,
    }
  end,
}

return M
