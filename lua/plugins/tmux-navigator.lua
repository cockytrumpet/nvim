local M = {
  'christoomey/vim-tmux-navigator',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'focus left window' })
    vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'focus right window' })
    vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'focus lower window' })
    vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'focus upper window' })
  end,
}

return M
