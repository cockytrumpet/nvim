local M = {
  'mawkler/modicator.nvim',
  event = 'BufWinEnter',
  init = function()
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
  config = function()
    require('modicator').setup()
  end,
}

return M
