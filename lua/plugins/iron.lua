local M = {
  'Vigemus/iron.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>rr', vim.cmd.IronRepl, desc = '󱠤 toggle REPL' },
    { '<leader>rR', vim.cmd.IronRestart, desc = '󱠤 restart REPL' },

    -- these keymaps need no right-hand-side, since that is defined by the
    -- plugin config further below
    { '+', mode = { 'n', 'x' }, desc = '󱠤 send-to-REPL Operator' },
    { '++', desc = '󱠤 send line to REPL' },
  },

  -- since irons's setup call is `require("iron.core").setup`, instead of
  -- `require("iron").setup` like other plugins would do, we need to tell
  -- lazy.nvim which module to via the `main` key
  main = 'iron.core',

  opts = {
    keymaps = {
      send_line = '++',
      visual_send = '+',
      send_motion = '+',
    },
    config = {
      -- this defined how the repl is opened. Here we set the REPL window
      -- to open in a horizontal split to a bottom, with a height of 10
      -- cells.
      repl_open_cmd = 'horizontal bot 10 split',

      -- This defines which binary to use for the REPL. If `ipython` is
      -- available, it will use `ipython`, otherwise it will use `python3`.
      -- since the python repl does not play well with indents, it's
      -- preferable to use `ipython` or `bypython` here.
      -- (see: https://github.com/Vigemus/iron.nvim/issues/348)
      repl_definition = {
        python = {
          command = function()
            local ipythonAvailable = vim.fn.executable 'ipython' == 1
            local binary = ipythonAvailable and 'ipython' or 'python3'
            return { binary }
          end,
        },
        ocaml = {
          command = function()
            local utopAvailable = vim.fn.executable 'utop' == 1
            local binary = utopAvailable and 'utop' or 'ocaml'
            return { binary }
          end,
        },
        java = {
          command = function()
            local jshellAvailable = vim.fn.executable 'jshell' == 1
            local binary = jshellAvailable and 'jshell' or 'java'
            return { binary }
          end,
        },
      },
    },
  },
}

return M
