local M = {
  'jcdickinson/codeium.nvim',
  event = { 'InsertEnter' },
  config = function()
    require('codeium').setup {
      enable_chat = true,
    }
  end,
}

return M
