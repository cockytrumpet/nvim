local M = {
  'folke/zen-mode.nvim',
  event = 'VeryLazy',
  opts = {
    window = {
      options = {
        signcolumn = 'yes', -- disable signcolumn
        number = true, -- disable number column
        relativenumber = true, -- disable relative numbers
        cursorline = false, -- disable cursorline
        cursorcolumn = false, -- disable cursor column
        foldcolumn = 'auto', -- disable fold column
        list = false, -- disable whitespace characters
      },
    },
  },
}

return M
