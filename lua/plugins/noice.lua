local M = {
  'folke/noice.nvim',
  -- event = "VeryLazy",
  lazy = false,
  opts = {
    -- add any options here
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
      },
    },
    {
      'stevearc/dressing.nvim',
      opts = {},
    },
  },
  config = function()
    require('noice').setup {
      cmdline = {
        enabled = true,
        view = 'cmdline_popup',
        format = {
          cmdline = { pattern = '^:', icon = '󰘳 ', lang = 'vim' },
          search_down = { kind = 'search', pattern = '^/', icon = '󰩊 ', lang = 'regex' },
          search_up = { kind = 'search', pattern = '^%?', icon = '󰩊 ', lang = 'regex' },
          filter = { pattern = '^:%s*!', icon = '󰻿 ', lang = 'bash' },
          lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
          help = { pattern = '^:%s*he?l?p?%s+', icon = '󰞋 ' },
        },
      },
      popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        backend = 'nui', -- backend to use to show regular cmdline completions
      },
      routes = {
        {
          filter = {
            event = 'lsp',
            any = {
              { find = 'formatting' },
              { find = 'Diagnosing' },
              { find = 'Diagnostics' },
              { find = 'diagnostics' },
              { find = 'code_action' },
              { find = 'Processing full semantic tokens' },
              { find = 'symbols' },
              { find = 'completion' },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'notify',
            any = {
              -- Telescope
              { find = 'Nothing currently selected' },
              { find = '^No information available$' },
              { find = 'Highlight group' },
              { find = 'no manual entry for' },
              { find = 'not have parser for' },

              -- ts
              { find = '_ts_parse_query' },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            kind = '',
            any = {

              -- Edit
              { find = '%d+ less lines' },
              { find = '%d+ fewer lines' },
              { find = '%d+ more lines' },
              { find = '%d+ change;' },
              { find = '%d+ line less;' },
              { find = '%d+ more lines?;' },
              { find = '%d+ fewer lines;?' },
              { find = '".+" %d+L, %d+B' },
              { find = '%d+ lines yanked' },
              { find = '^Hunk %d+ of %d+$' },
              { find = '%d+L, %d+B$' },

              -- Save
              { find = ' bytes written' },

              -- Redo/Undo
              { find = ' changes; before #' },
              { find = ' changes; after #' },
              { find = '1 change; before #' },
              { find = '1 change; after #' },

              -- Yank
              { find = ' lines yanked' },

              -- Move lines
              { find = ' lines moved' },
              { find = ' lines indented' },

              -- Bulk edit
              { find = ' fewer lines' },
              { find = ' more lines' },
              { find = '1 more line' },
              { find = '1 line less' },

              -- General messages
              { find = 'Already at newest change' },
              { find = 'Already at oldest change' },
              { find = "E21: Cannot make changes, 'modifiable' is off" },
            },
          },
          opts = { skip = true },
        },
      },
      lsp = {
        hover = {
          enabled = true,
          silent = true,
        },
        progress = {
          enabled = false,
        },
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            trigger = true,
            luasnip = true,
            throttle = 50,
          },
          view = nil, -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {
            focusable = false,
            size = {
              max_height = 15,
              max_width = 60,
            },
            win_options = {
              wrap = false,
            },
          },
        },
        documentation = {
          opts = {
            border = {
              padding = { 0, 0 },
            },
          },
        },
        override = {
          -- override the default lsp markdown formatter with Noice
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          -- override the lsp markdown formatter with Noice
          ['vim.lsp.util.stylize_markdown'] = true,
          -- override cmp documentation with Noice (needs the other options to work)
          ['cmp.entry.get_documentation'] = true,
        },
      },
      ---@type NoiceConfigViews
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = '50%',
          },
          size = {
            width = 60,
            height = 'auto',
          },
        },
        popupmenu = {
          relative = 'editor',
          backend = 'nui',
          position = {
            row = 8,
            col = '50%',
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = 'rounded',
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
          },
        },
        mini = {
          zindex = 100,
          win_options = { winblend = 15 },
        },
      },
      smart_move = {
        enabled = true,
        excluded_filetypes = { 'cmp_menu', 'cmp_docs', 'notify' },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = true,
        inc_rename = false,
        long_message_to_split = true,
      },
      health = {
        checker = true, -- Disable if you don't want health checks to run
      },
    }
  end,
}

return M
