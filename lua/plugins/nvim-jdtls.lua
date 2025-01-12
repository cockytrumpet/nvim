local M = {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'mfussenegger/nvim-dap',
    {
      'ray-x/lsp_signature.nvim',
      event = 'VeryLazy',
      opts = {},
      config = function(_, opts)
        require('lsp_signature').setup(opts)
      end,
    },
  },
}

return M
