local M = {
  'tzachar/highlight-undo.nvim',
  event = 'BufReadPost',
  config = function()
    require('highlight-undo').setup {}
  end,
}

return M
