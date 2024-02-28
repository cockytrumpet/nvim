local M = {
  'mfussenegger/nvim-dap-python',
  ft = 'python',
  dependencies = {
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
  },
  config = function(_, opts)
    opts = opts
    local path = '~/.pyenv/shims/python3'
    require('dap-python').setup(path)
  end,
}

return M
