local M = {
  'mbbill/undotree',
  event = 'VeryLazy',
  config = function()
    vim.keymap.set('n', '<leader>u', '<CMD>UndotreeToggle<CR>', { desc = 'Undotree' })
  end,
}

return M
