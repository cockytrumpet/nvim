local M = {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
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
      suggestion = {
        enabled = true,
        auto_trigger = true,
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
  end,
}

return M
