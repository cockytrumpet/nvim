local M = {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },
  config = function()
    -- require('core.utils').load_mappings 'lspconfig'
    -- require('telescope').extensions.metals.commands()
  end,
}

return M
