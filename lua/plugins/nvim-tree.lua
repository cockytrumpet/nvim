local M = {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'antosha417/nvim-lsp-file-operations',
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  opts = {
    git = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    diagnostics = {
      enable = false,
      show_on_dirs = false,
      show_on_open_dirs = false,
    },
    modified = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    filters = { custom = { '^.git$' } },
    renderer = {
      highlight_git = true,
      highlight_diagnostics = true,
      highlight_opened_files = 'icon',
      highlight_modified = 'none',
      highlight_bookmarks = 'all',
      icons = {
        show = {
          git = true,
        },
      },
    },
    view = {
      side = 'left',
      width = { min = 40, padding = 2 },
    },
    hijack_unnamed_buffer_when_opening = true,
    hijack_cursor = false,
    sync_root_with_cwd = true,
    tab = {
      sync = {
        open = false,
        close = false,
      },
    },
  },
}
return M