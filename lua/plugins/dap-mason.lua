local M = {
  'jay-babu/mason-nvim-dap.nvim',
  event = 'VeryLazy',
  init = function()
    vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
  end,
  config = function()
    local dap = require 'dap'

    dap.adapters.codelldb = {
      id = 'codelldb',
      type = 'server',
      port = '${port}',
      executable = {
        command = os.getenv 'HOME' .. '/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
        args = { '--port', '${port}' },
      },
    }

    dap.configurations.cpp = {
      {
        -- Change it to "cppdbg" if you have vscode-cpptools
        type = 'codelldb',
        request = 'launch',
        program = function()
          -- Compile and return exec name
          local filetype = vim.bo.filetype
          local filename = vim.fn.expand '%'
          local basename = vim.fn.expand '%:t:r'
          local makefile = os.execute '(ls | grep -i makefile)'
          if makefile == 'makefile' or makefile == 'Makefile' then
            os.execute 'make clean debug'
          else
            if filetype == 'c' then
              os.execute(string.format('gcc -g -o %s %s', basename, filename))
            else
              os.execute(string.format('g++ -g -o %s %s', basename, filename))
            end
          end
          return basename
        end,

        args = function()
          local argv = {}
          arg = vim.fn.input(string.format 'argv: ')
          for a in string.gmatch(arg, '%S+') do
            table.insert(argv, a)
          end
          vim.cmd 'echo ""'
          return argv
        end,
        cwd = '${workspaceFolder}',
        -- Uncomment if you want to stop at main
        -- stopAtEntry = true,
        MIMode = 'lldb',
        miDebuggerPath = '/usr/bin/lldb',
        setupCommands = {
          {
            text = 'settings set target.process.follow-fork-mode child',
            description = 'follow forks',
            ignoreFailures = false,
          },
        },
      },
    }

    dap.configurations.c = dap.configurations.cpp

    dap.configurations.rust = {
      {
        type = 'codelldb',
        request = 'launch',
        -- This is where cargo outputs the executable
        program = function()
          os.execute 'cargo build &> /dev/null'
          return 'target/debug/${workspaceFolderBasename}'
        end,
        args = function()
          local argv = {}
          arg = vim.fn.input(string.format 'argv: ')
          for a in string.gmatch(arg, '%S+') do
            table.insert(argv, a)
          end
          return argv
        end,
        cwd = '${workspaceFolder}',
        -- Uncomment if you want to stop at main
        -- stopOnEntry = true,
        MIMode = 'lldb',
        miDebuggerPath = '/usr/bin/lldb',
        setupCommands = {
          {
            text = 'settings set target.process.follow-fork-mode child',
            description = 'follow forks',
            ignoreFailures = false,
          },
        },
      },
    }

    dap.configurations.scala = {
      {
        type = 'scala',
        request = 'launch',
        name = 'RunOrTest',
        metals = {
          runType = 'runOrTestFile',
          mainClass = 'Main',
          -- buildTarget = "root",
          --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
        },
      },
      {
        type = 'scala',
        request = 'launch',
        name = 'Test Target',
        metals = {
          runType = 'testTarget',
          mainClass = 'Main',
          -- buildTarget = "test",
        },
      },
    }
  end,
  dependencies = {
    {
      'williamboman/mason.nvim',
    },
    'mfussenegger/nvim-dap',
    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        local present, nvim_dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
        if not present then
          return
        end

        nvim_dap_virtual_text.setup {
          enabled = true, -- enable this plugin (the default)
          enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          show_stop_reason = true, -- show stop reason when stopped for exceptions
          commented = false, -- prefix virtual text with comment string
          only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
          all_references = true, -- show virtual text on all all references of the variable (not only definitions)
          clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)

          ---@diagnostic disable-next-line: unused-local
          display_callback = function(variable, buf, stackframe, node, options)
            if options.virt_text_pos == 'inline' then
              return ' = ' .. variable.value
            else
              return variable.name .. ' = ' .. variable.value
            end
          end,

          virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

          all_frames = false,
          virt_lines = false,
          virt_text_win_col = nil,
        }
      end,
    },
  },
  opts = {
    handlers = {},
  },
}

return M
