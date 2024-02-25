local M = {
  'sontungexpt/sttusline',
  priority = 999,
  lazy = false,
  branch = 'table_version',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  -- event = { 'BufEnter' },
  config = function(_, opts)
    require('sttusline').setup {
      on_attach = function(create_update_group) end,

      -- the colors of statusline will be set follow the colors of the active buffer
      -- statusline_color = "#fdff00",
      statusline_color = 'StatusLine',
      disabled = {
        filetypes = {
          'NvimTree',
          'lazy',
        },
        buftypes = {
          'terminal',
          'undotree_2',
          'diffpanel_3',
        },
      },
      components = {
        'mode',
        --        'os-uname',
        'filename',
        'git-branch',
        'git-diff',
        '%=',
        'diagnostics',
        'lsps-formatters',
        -- 'copilot',
        'copilot-loading',
        'indent',
        'encoding',
        'pos-cursor',
        'pos-cursor-progress',
      },
    }
  end,
}

return M
