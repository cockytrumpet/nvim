--[[
local M = {
  dir = '~/lua/plugins/YtAudio',
  event = 'VeryLazy',
  name = 'YtAudio',
  opts = true,
}
]]

local M = {
  'cockytrumpet/YtAudio',
  -- branch = 'now_playing',
  init = function()
    vim.api.nvim_set_keymap('n', '<leader>yp', ':YAPlay<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ys', ':YAStop<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>y1', ':YAFav https://www.youtube.com/watch?v=abUT5IEkwrg<CR>', { noremap = true, silent = true })
  end,
  event = 'VeryLazy',
  opts = true,
}
return M
