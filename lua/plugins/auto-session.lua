local function restore_nvim_tree()
  local nvim_tree = require 'nvim-tree'
  nvim_tree.change_dir(vim.fn.getcwd())
end

local M = {
  'rmagatti/auto-session',
  event = 'VeryLazy',
  opts = true,
  config = function()
    local auto_session = require 'auto-session'

    auto_session.setup {
      bypass_session_save_file_types = { '' },
      log_level = 'warn',
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { '~/', '~/Dev/', '~/Downloads', '~/Documents', '~/Desktop/' },
      auto_session_use_git_branch = false,
      auto_save_enabled = true,
      auto_session_create_enabled = false,
      pre_save_cmds = {
        function()
          local filetypes_to_close = { 'minimap', 'NvimTree*', 'Trouble', 'Outline' }
          for _, filetype in ipairs(filetypes_to_close) do
            local cmd = 'bw ' .. filetype
            pcall(vim.cmd, cmd)
          end
        end,
      },

      --[[
      pre_restore_cmds = {
        function()
          vim.api.nvim_input '<ESC>:%bd!<CR>'
        end,
      },
]]
      cwd_change_handling = { -- table: Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
        restore_upcoming_session = true, -- boolean: restore session for upcoming cwd on cwd change
        pre_cwd_changed_hook = nil,
        post_cwd_changed_hook = restore_nvim_tree, -- function: This is called after auto_session code runs for the `DirChanged` autocmd
      },
    }

    local keymap = vim.keymap

    keymap.set('n', '<leader>sr', '<cmd>SessionRestore<CR>', { desc = 'session restore (cwd)' }) -- restore last workspace session for current directory
    keymap.set('n', '<leader>ss', '<cmd>SessionSave<CR>', { desc = 'session save (cwd)' }) -- save workspace session for current working directory
    keymap.set('n', '<leader>sd', '<cmd>SessionDelete<CR>', { desc = 'session delete (cwd)' }) -- delete workspace session for current working directory
    keymap.set('n', '<leader>sD', '<cmd>Autosession delete<CR>', { desc = 'session delete' }) -- delete workspace session (picker)
    keymap.set('n', '<leader>sl', '<cmd>Autosession search<CR>', { desc = 'session list' }) -- list saved sessions (picker)
  end,
}

return M
