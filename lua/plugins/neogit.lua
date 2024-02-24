local M = {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'nvim-telescope/telescope.nvim', -- optional
    'sindrets/diffview.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
  },
  config = true,
  opts = function()
    local config = require 'neogit.config'
    config.auto_show_console = false
    return config
  end,
  ft = { 'diff' },
  cmd = { 'Neogit' },
  --[[ setup = function()
    require("neogit").setup {}
  end, ]]
}

return M
