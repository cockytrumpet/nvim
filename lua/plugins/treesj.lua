local M = {
  'Wansmer/treesj',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', '<leader>j', '<CMD>TSJToggle<CR>', { desc = 'split/join' })
    require('treesj').setup {
      use_default_keymaps = false,
    }
  end,
}

return M
