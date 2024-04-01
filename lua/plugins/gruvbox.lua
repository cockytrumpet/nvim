local M = {
  'ellisonleao/gruvbox.nvim',
  event = 'VeryLazy',
  -- priority = 1000,
  config = {
    overrides = {
      SignColumn = { bg = 'NONE' },
      FoldColumn = { bg = 'NONE' },
      DiagnosticError = { bg = 'NONE' },
      DiagnosticWarn = { bg = 'NONE' },
      FloatBorder = { bg = 'NONE' },
    },
  },
}

return M
