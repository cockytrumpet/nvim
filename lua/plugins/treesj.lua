local M = {
  'Wansmer/treesj',
  event = 'BufWinEnter',
  config = function()
    vim.keymap.set('n', '<leader>s', '<CMD>TSJToggle<CR>', { desc = 'split/join' })
    require('treesj').setup {
      use_default_keymaps = false,
    }
  end,
}

return M
