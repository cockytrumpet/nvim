local M = {
  'sindrets/diffview.nvim',
  cmd = 'DiffviewOpen',
  config = function()
    require('diffview').setup {
      enhanced_diff_hl = true,
      view = {
        merge_tool = {
          layout = 'diff3_mixed',
          disable_diagnostics = true,
        },
      },
    }
  end,
}

return M
