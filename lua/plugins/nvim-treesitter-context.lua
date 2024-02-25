local M = {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufWinEnter',
  opts = {
    throttle = true,
    patterns = {
      default = {
        'class',
        'function',
        'method',
      },
    },
  },
}

return M
