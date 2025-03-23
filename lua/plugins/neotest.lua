local M = {
  'nvim-neotest/neotest',
  ft = { 'python', 'c', 'cpp', 'go', 'java' },
  dependencies = {
    'nvim-neotest/nvim-nio',
    'stevanmilic/neotest-scala',
    'antoinemadec/FixCursorHold.nvim',
    {
      'rcasia/neotest-java',
      ft = { 'java' },
    },
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-vim-test',
    'nvim-treesitter/nvim-treesitter',
  },
  init = function()
    vim.keymap.set('n', '<leader>ns', '<cmd>Neotest summary<cr>', { desc = 'summary window' })
    vim.keymap.set('n', '<leader>no', function()
      require('neotest').output.open()
    end, { desc = 'test output' })
    vim.keymap.set('n', '<leader>nr', function()
      require('neotest').run.run()
    end, { desc = 'run nearest' })
    vim.keymap.set('n', '<leader>nf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = 'run file' })
    vim.keymap.set('n', '<leader>nd', function()
      require('neotest').run.run { strategy = 'dap' }
    end, { desc = 'debug nearest' })
    vim.keymap.set('n', '<leader>na', function()
      require('neotest').run.attach()
    end, { desc = 'attach nearest' })
    vim.keymap.set('n', '<leader>nw', function()
      require('neotest').watch.toggle(vim.fn.expand '%')
    end, { desc = 'watch file' })
  end,
  config = function()
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'

    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          -- TODO: filter message here
          return message
        end,
      },
    }, neotest_ns)

    require('neotest').setup {
      adapters = {
        require 'neotest-java',
        require 'neotest-go',
        -- require 'neotest-rust',
        require 'neotest-scala' {
          runner = 'sbt',
          framework = 'scalatest',
        },
        require 'neotest-python' {
          dap = {
            justMyCode = false,
            console = 'integratedTerminal',
          },
          args = { '--log-level', 'DEBUG', '--quiet' },
          runner = 'pytest',
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
