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
  init = function()
    -- stylua: ignore
    vim.api.nvim_set_keymap(
      'n',
      '<leader>ys',
      ':YAStop<CR>',
      { desc = 'stop audio', noremap = true, silent = true })
    -- stylua: ignore
    vim.api.nvim_set_keymap(
      'n',
      '<leader>ya',
      ':YAPlay<CR>',
      { desc = 'play audio', noremap = true, silent = true })
    vim.api.nvim_set_keymap(
      'n',
      '<leader>y1',
      ':YAPlay https://www.youtube.com/watch?v=LXyTZIEQAsI<CR>',
      { desc = 'Chillstep Cyber City Radio', noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>y2',
      ':YAPlay https://www.youtube.com/watch?v=abUT5IEkwrg<CR>',
      { desc = 'Future Garage for Smooth Workflow', noremap = true, silent = true }
    )
  end,
  event = 'VeryLazy',
  opts = {
    notifications = false,
    -- icon = '',
  },
}
return M
