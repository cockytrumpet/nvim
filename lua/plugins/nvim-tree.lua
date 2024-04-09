vim.cmd [[
:hi NvimTreeDiagnosticErrorIcon     ctermfg=9 guifg=NvimLightRed
:hi NvimTreeDiagnosticWarnIcon      ctermfg=11 guifg=NvimLightYellow
:hi NvimTreeDiagnosticInfoIcon      ctermfg=14 guifg=NvimLightCyan
:hi NvimTreeDiagnosticHintIcon      ctermfg=12 guifg=NvimLightBlue
]]

local M = {
  'nvim-tree/nvim-tree.lua',
  event = 'VeryLazy',
  init = function()
    vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>', { desc = 'toggle nvimtree' })
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
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
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          git = true,
        },
        web_devicons = {},
        --[[
        glyphs = {
          folder = {
            arrow_closed = '', -- arrow when folder is closed
            arrow_open = '', -- arrow when folder is open
          },
        },
]]
      },
    },
    view = {
      side = 'left',
      relativenumber = true,
      -- width = { min = 20, padding = 2 },
      width = 35,
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
