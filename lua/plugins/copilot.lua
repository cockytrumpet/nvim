local M = {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
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
      suggestion = { enabled = false, auto_trigger = false },
      panel = { enabled = false },
    }--[[
    require('copilot').setup {
      suggestion = {
        enabled = false,
        auto_trigger = false,
        keymap = {
          accept = '<M-\\>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      panel = {
        enabled = false,
      },
      filetypes = {
        gitcommit = false,
        TelescopePrompt = false,
      },
      server_opts_overrides = {
        trace = 'verbose',
        settings = {
          advanced = {
            listCount = 3,
            inlineSuggestCount = 3,
          },
        },
      },
    }
]]
  end,
}

return M
