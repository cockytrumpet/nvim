local M = {
  'rmagatti/auto-session',
  event = 'VeryLazy',
  opts = true,
  config = function()
    local auto_session = require 'auto-session'

    auto_session.setup {
      log_level = 'warn',
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { '~/', '~/Dev/', '~/Downloads', '~/Documents', '~/Desktop/' },
      auto_session_use_git_branch = nil,
    }

    local keymap = vim.keymap

    keymap.set('n', '<leader>sr', '<cmd>SessionRestore<CR>', { desc = 'session restore (cwd)' }) -- restore last workspace session for current directory
    keymap.set('n', '<leader>ss', '<cmd>SessionSave<CR>', { desc = 'session save (cwd)' }) -- save workspace session for current working directory
    keymap.set('n', '<leader>sd', '<cmd>SessionDelete<CR>', { desc = 'session delete (cwd)' }) -- delete workspace session for current working directory
    keymap.set('n', '<leader>sD', '<cmd>Autosession delete<CR>', { desc = 'session delete' }) -- delete workspace session for current working directory
    keymap.set('n', '<leader>sl', '<cmd>Autosession search<CR>', { desc = 'session list' }) -- list saved sessions
  end,
}

return M
