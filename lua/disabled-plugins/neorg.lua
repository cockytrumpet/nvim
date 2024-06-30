local M = {
  'nvim-neorg/neorg',
  -- build = ':Neorg sync-parsers',
  enabled = false, -- TODO: fix breaking changes if this is still wanted
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'Neorg',
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
            },
            default_workspace = 'notes',
          },
        },
      },
    }
    --[[
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
]]
  end,
}

return M
