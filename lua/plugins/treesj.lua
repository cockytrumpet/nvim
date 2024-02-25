local M = {
  'Wansmer/treesj',
  event = 'BufWinEnter',
  config = function()
    require('treesj').setup {
      use_default_keymaps = false,
    }
  end,
}

return M
