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
  -- branch = 'testing',
  init = function()
    vim.api.nvim_set_keymap('n', '<leader>yp', ':YAPlay<CR>', { desc = 'play audio', noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ys', ':YAStop<CR>', { desc = 'stop audio', noremap = true, silent = true })
    vim.api.nvim_set_keymap(
      'n',
      '<leader>y1',
      ':YAFav https://www.youtube.com/watch?v=LXyTZIEQAsI<CR>',
      { desc = 'Chillstep Cyber City Radio', noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>y2',
      ':YAFav https://www.youtube.com/watch?v=abUT5IEkwrg<CR>',
      { desc = 'Future Garage for Smooth Workflow', noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>y3',
      ':YAFav https://www.youtube.com/watch?v=GJDmtNur9tA<CR>',
      { desc = 'Blade Runner Ambient Music', noremap = true, silent = true }
    )
  end,
  event = 'VeryLazy',
  opts = {
    notifications = false,
  },
}
return M
