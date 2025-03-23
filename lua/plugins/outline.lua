local M = {
  'hedyhli/outline.nvim',
  lazy = true,
  cmd = { 'Outline', 'OutlineOpen' },
  keys = {
    { '<leader>s', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  opts = {
    outline_window = {
      position = 'left',
      winhl = 'WinSeparator:FloatBorder',
      show_cursorline = true,
      hide_cursor = true,
      show_symbol_lineno = true,
      width = 18,
      relative_width = true,
    },
    outline_items = {
      show_symbol_details = false,
      show_symbol_lineno = true,
    },
    preview_window = {
      auto_preview = true,
      open_hover_on_preview = true,
      border = 'rounded',
    },
  },
}

return M
