local M = {
  'zbirenbaum/copilot.lua',
  -- event = 'InsertEnter',
  enabled = false,
  cmd = 'Copilot',
  event = 'VeryLazy',
  init = function()
    vim.keymap.set('n', '<leader>gc', '<cmd>Copilot toggle<cr>', { noremap = true, silent = true, desc = 'copilot toggle' })
  end,
  dependencies = {
    {
      'zbirenbaum/copilot-cmp',
      config = function()
        require('copilot_cmp').setup()
      end,
    },
  },
  config = function()
    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
    }
  end,
}

return M
