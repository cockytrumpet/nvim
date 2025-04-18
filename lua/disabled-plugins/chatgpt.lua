local M = {
  'jackMort/ChatGPT.nvim',
  enabled = false,
  cmd = { 'ChatGPT', 'ChatGPTActAs', 'ChatGPTCompleteCode', 'ChatGPTEditWithInstructions', 'ChatGPTRun' },
  config = function()
    require('chatgpt').setup()
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
}

return M
