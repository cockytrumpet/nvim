---@diagnostic disable: undefined-field

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function empty()
  return '%='
end

local function lsp()
  -- LSPs
  local msg = ''
  local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
  local clients = vim.lsp.get_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      if msg ~= '' then
        msg = msg .. ', '
      end
      msg = msg .. client.name
    end
  end
  -- Formatters
  local formatters = require('conform').list_formatters_for_buffer()
  if next(formatters) ~= nil then
    for _, linter in ipairs(formatters) do
      msg = msg .. ', ' .. linter
    end
  end
  return msg
end

local M = {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  priority = 999,
  dependencies = { 'nvim-tree/nvim-web-devicons', 'AndreM222/copilot-lualine' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'catppuccin',
        section_separators = { '', '' },
        component_separators = { '', '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          {
            'diff',
            source = diff_source,
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
          },
        },
        lualine_c = {
          'filename',
          'diagnostics',
          { empty },
          --[[ {
            require('noice').api.status.message.get_hl,
            cond = require('noice').api.status.message.has,
          }, ]]
          --[[ {
            require('noice').api.status.command.get,
            cond = require('noice').api.status.command.has,
            color = { fg = '#ff9e64' },
          }, ]]
          {
            require('noice').api.status.mode.get,
            cond = require('noice').api.status.mode.has,
            color = { fg = '#ff9e64' },
          },
          --[[ {
            require('noice').api.status.search.get,
            cond = require('noice').api.status.search.has,
            color = { fg = '#ff9e64' },
          }, ]]
        },
        lualine_x = {
          {
            'copilot',
            symbols = {
              status = {
                icons = {
                  enabled = ' ',
                  sleep = ' ',
                  disabled = ' ',
                  warning = ' ',
                  unknown = ' ',
                },
                hl = {
                  enabled = '#94e2d5', -- #a6e3a1 for green
                  sleep = '#AEB7D0',
                  disabled = '#6272A4',
                  warning = '#fab387',
                  unknown = '#f38ba8',
                },
              },
              spinners = require('copilot-lualine.spinners').dots,
              spinner_color = '#6272A4',
            },
            show_colors = true,
            show_loading = true,
          },
          { lsp, color = { fg = '#89b4fa' } },
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    }
  end,
}

return M
