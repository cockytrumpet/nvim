-- kill lsps that haven't been used in a while
local M = {
  'hinell/lsp-timeout.nvim',
  enabled = false,
  event = 'VeryLazy',
  dependencies = { 'neovim/nvim-lspconfig' },
  setup = function()
    vim.g.lspTimeoutConfig = {
      stopTimeout = 1000 * 60 * 5, -- ms, timeout before stopping all LSPs
      startTimeout = 1000 * 10, -- ms, timeout before restart
      silent = false, -- true to suppress notifications
      filetypes = {
        ignore = { -- filetypes to ignore; empty by default
          'help',
        }, -- for these filetypes
      },
    }
  end,
}

return M
