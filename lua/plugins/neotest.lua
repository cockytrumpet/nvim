local M = {
  'nvim-neotest/neotest',
  ft = { 'python', 'c', 'cpp', 'rust', 'go' },
  dependencies = {
    'stevanmilic/neotest-scala',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-vim-test',
  },
  config = function()
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'

    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    require('neotest').setup {
      adapters = {
        -- require("neotest-rust"),
        require 'neotest-scala' {
          runner = 'sbt',
          framework = 'scalatest',
        },
        require 'neotest-python' {
          dap = { justMyCode = false },
        },
        require 'neotest-plenary',
        require 'neotest-vim-test' {
          ignore_file_types = { 'python', 'vim', 'lua' },
        },
      },
      diagnostic = {
        enabled = true,
      },
      floating = {
        border = 'rounded',
        max_height = 0.6,
        max_width = 0.6,
      },
      icons = {
        child_indent = '│',
        child_prefix = '├',
        collapsed = '─',
        expanded = '╮',
        failed = '✖',
        final_child_indent = ' ',
        final_child_prefix = '╰',
        non_collapsible = '─',
        passed = '',
        running = '',
        skipped = '',
        unknown = '',
      },
      output = {
        enabled = true,
        open_on_run = true,
      },
      run = {
        enabled = true,
      },
      status = {
        enabled = true,
      },
      strategies = {
        integrated = {
          height = 40,
          width = 120,
        },
      },
      summary = {
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = 'a',
          expand = { '<CR>', '<2-LeftMouse>' },
          expand_all = 'e',
          jumpto = 'i',
          output = 'o',
          run = 'r',
          short = 'O',
          stop = 'u',
        },
      },
    }
  end,
}

return M
