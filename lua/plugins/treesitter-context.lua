local M = {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufWinEnter',
  init = function()
    vim.keymap.set('n', '[u', function()
      require('treesitter-context').go_to_context(vim.v.count1)
    end, { silent = true })
  end,
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
