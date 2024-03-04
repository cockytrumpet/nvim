local M = {
  'm-demare/hlargs.nvim',
  event = 'VeryLazy',
  config = function()
    require('hlargs').setup {
      hl_priority = 200,
    }
  end,
}

return M
