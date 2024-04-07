local M = { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Sets the loading event to 'VeryLazy'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      ['<leader>b'] = { name = '[b]uffer', _ = 'which_key_ignore' },
      ['<leader>c'] = { name = '[c]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[d]iagnostic/debug', _ = 'which_key_ignore' },
      ['<leader>D'] = { name = '[D]ad-bod', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = '[f]ind', _ = 'which_key_ignore' },
      ['<leader>fC'] = { name = '[C]opilot Chat', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[g]it', _ = 'which_key_ignore' },
      ['<leader>ch'] = { name = 'copilot c[h]at', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[r]un', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[s]ession', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[t]ab/term/todo', _ = 'which_key_ignore' },
      ['<leader>tr'] = { name = '[r]un', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[w]indow', _ = 'which_key_ignore' },
      ['<leader>y'] = { name = '[y]taudio', _ = 'which_key_ignore' },
      ['<leader>z'] = { name = '[z]en mode', _ = 'which_key_ignore' },
    }
  end,
}

return M
