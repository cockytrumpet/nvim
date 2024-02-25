local M = {
  'Wansmer/treesj',
  config = function()
    require('treesj').setup {
      use_default_keymaps = false,
    }
  end,
}

return M
