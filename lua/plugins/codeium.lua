local M = {
  'jcdickinson/codeium.nvim',
  event = { 'InsertEnter' },
  config = function()
    require('codeium').setup()
  end,
}

return M
