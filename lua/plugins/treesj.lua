local M = {
  'Wansmer/treesj',
  config = function()
    require('treesj').setup {
      use_default_keymaps = true,
    }
  end,
}

return M
