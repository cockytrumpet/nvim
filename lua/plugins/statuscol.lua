local M = {
  'luukvbaal/statuscol.nvim',
  branch = '0.10',
  config = function()
    local builtin = require 'statuscol.builtin'
    require('statuscol').setup {
      relculright = true,
      bt_ignore = {
        'nofile',
        'prompt',
        'terminal',
        'quickfix',
      },
      ft_ignore = {
        'NvimTree',
        'dapui_watches',
        'dap-repl',
        'dapui_console',
        'dapui_stacks',
        'dapui_breakpoints',
        'dapui_scopes',
        'help',
        'vim',
        'Trouble',
        'noice',
        'lazy',
        'neotest-summary',
        'terminal',
        'Outline',
        'undotree',
        'diff',
      },
      segments = {
        {
          sign = {
            namespace = { 'gitsigns' },
            name = { '.*' },
            maxwidth = 1,
            colwidth = 2,
            auto = false,
            wrap = true,
            foldclosed = true,
          },
          auto = false,
          click = 'v:lua.ScSa',
        },
        {
          sign = {
            namespace = { 'diagnostic' },
            maxwidth = 1,
            colwidth = 2,
            auto = false,
            wrap = true,
            foldclosed = true,
          },
          click = 'v:lua.ScSa',
        },
        {
          text = { builtin.foldfunc },
          click = 'v:lua.ScFa',
          auto = false,
          condition = { true },
        },
        {
          text = { '  ', builtin.lnumfunc, ' ' },
          click = 'v:lua.ScLa',
          condition = { true, builtin.not_empty },
        },
      },
    }
  end,
}

return M
