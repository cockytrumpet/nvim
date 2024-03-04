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
--[[
-- FIXME: This is a temporary function to test diagnostics
local function make_some_errors()
  vim.api.nvim_win_get_option(0, 'number')
  1/0
end
]]
local function lsp()
  local msg = ''
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }
  local excluded_lsps = { 'copilot' }
  local excluded_formatters = {}

  -- LSPs
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    if not vim.tbl_contains(excluded_lsps, client.name) then
      if msg ~= '' then
        msg = msg .. ', '
      end
      msg = msg .. client.name
    end
  end
  -- Formatters
  local formatters = require('conform').list_formatters_for_buffer()
  if next(formatters) ~= nil then
    for _, formatter in ipairs(formatters) do
      if not vim.tbl_contains(excluded_formatters, formatter) then
        if msg ~= '' then
          msg = msg .. ', '
        end
        msg = msg .. formatter
      end
    end
  end

  -- msg = "' " .. msg
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
        always_divide_middle = false,
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
          '%=',
          {
            require('noice').api.status.mode.get,
            cond = require('noice').api.status.mode.has,
            color = { fg = '#ff9e64' },
          },
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
                  enabled = '#94e2d5',
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
