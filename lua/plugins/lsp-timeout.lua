-- kill lsps that haven't been used in a while
local M = {
  'hinell/lsp-timeout.nvim',
  enabled = false,
  event = 'VeryLazy',
  dependencies = { 'neovim/nvim-lspconfig' },
}

return M
