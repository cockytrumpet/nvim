local M = { -- theme
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    -- catppuccin, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
    vim.cmd.colorscheme 'catppuccin'
    -- You can configure highlights by doing something like
    -- vim.cmd.hi 'Comment gui=none'
  end,
}

return M
