local M = {
  'nvim-tree/nvim-tree.lua',
  event = 'VeryLazy',
  dependencies = {
    'antosha417/nvim-lsp-file-operations',
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  init = function()
    vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>', { desc = 'toggle nvimtree' })
  end,
  opts = {
    git = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    modified = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = false,
    },
    filters = { custom = { '^.git$' } },
    renderer = {
      highlight_git = 'name',
      highlight_diagnostics = 'none',
      highlight_opened_files = 'icon',
      highlight_modified = 'none',
      highlight_bookmarks = 'all',
      root_folder_label = false,
      icons = {
        show = {
          git = true,
        },
      },
    },
    view = {
      side = 'left',
      relativenumber = true,
      width = { min = 20, padding = 2 },
    },
    hijack_unnamed_buffer_when_opening = false,
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
