local M = {
  'jcdickinson/codeium.nvim',
  event = { 'InsertEnter', 'LspAttach' },
  config = function()
    require('codeium').setup()
  end,
}

return M
