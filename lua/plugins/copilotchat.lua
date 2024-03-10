local M = {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'canary',
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  init = function()
    vim.keymap.set('n', '<leader>cht', '<cmd>CopilotChatToggle<cr>', { desc = 'toggle Copilot Chat' })
    vim.keymap.set('n', '<leader>che', '<cmd>CopilotChatExplain<cr>', { desc = 'explain' })
    vim.keymap.set('n', '<leader>chf', '<cmd>CopilotChatFix<cr>', { desc = 'fix code' })
    vim.keymap.set('n', '<leader>cho', '<cmd>CopilotChatOptimize<cr>', { desc = 'optimize code' })
    vim.keymap.set('n', '<leader>chd', '<cmd>CopilotChatDocs<cr>', { desc = 'write documentation' })
    vim.keymap.set('n', '<leader>chF', '<cmd>CopilotChatFixDiagnostic<cr>', { desc = 'fix diagnostic' })
    vim.keymap.set('n', '<leader>chc', '<cmd>CopilotChatCommit<cr>', { desc = 'write commit message' })
    vim.keymap.set('n', '<leader>chC', '<cmd>CopilotChatCommitStaged<cr>', { desc = 'write commit message (staged)' })
    vim.keymap.set('n', '<leader>chr', '<cmd>CopilotChatReset<cr>', { desc = 'reset chat window' })
    vim.keymap.set('n', '<leader>chq', function()
      local input = vim.fn.input 'Quick Chat: '
      if input ~= '' then
        require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
      end
    end, { desc = 'quick chat (buffer)' })

    vim.keymap.set('n', '<leader>fCa', function()
      local actions = require 'CopilotChat.actions'
      require('CopilotChat.integrations.telescope').pick(actions.help_actions())
    end, { desc = 'CopilotChat - Help actions' })

    -- Show prompts actions with telescope
    vim.keymap.set('n', '<leader>fCp', function()
      local actions = require 'CopilotChat.actions'
      require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
    end, { desc = 'CopilotChat - Prompt actions' })
  end,
  opts = {
    debug = true, -- Enable debugging
    -- See Configuration section for rest
  },
  -- See Commands section for default commands if you want to lazy load on them
}

return M
