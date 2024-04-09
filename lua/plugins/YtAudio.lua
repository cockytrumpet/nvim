-- toggle dev/live mode
-------------------------
local mode = 'live'
-- local mode = 'dev'
-------------------------

local dev = {
  dir = '~/dev/lua/plugins/YtAudio',
  name = 'YtAudio',
  opts = {
    dev_mode = true,
    notifications = false,
    volume = 50,
    icon = '',
  },
}

local live = {
  'cockytrumpet/YtAudio',
  opts = {
    notifications = false,
    volume = 25,
    -- icon = '',
  },
}

local get_opts = function()
  if mode == 'dev' then
    return dev
  else
    return live
  end
end

local M = {
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
    vim.api.nvim_set_keymap(
      'n',
      '<leader>y3',
      ':YAPlay https://www.youtube.com/watch?v=RxLQ9boJJCE<CR>',
      { desc = 'Dubstep/Future Bass', noremap = true, silent = true }
    )
  end,
  event = 'VeryLazy',
  -- cmd = 'YAPlay',
}

M = vim.tbl_extend('keep', get_opts(), M)
return M
