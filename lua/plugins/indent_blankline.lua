local M = {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  opts = {
    exclude = {
      filetypes = {
        'neotest-summary',
        'Neogit*',
        'terminal',
        'diff',
        'undotree',
        'Outline',
        'TelescopePrompt',
      },
      buftypes = { 'terminal' },
    },
    indent = {
      char = '▏', -- Thiner, not suitable when enable scope
      tab_char = '▏',
      -- highlight = highlight,
    },
    scope = {
      -- Rely on treesitter, bad performance
      enabled = true,
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
      include = {
        node_type = {
          lua = { 'return_statement', 'table_constructor' },
          python = { 'function_definition', 'class_definition', 'for_statement', 'while_statement' },
          java = { 'function_definition', 'class_definition' },
        },
      },
    },
  },
  config = function(_, opts)
    local ibl = require 'ibl'
    local hooks = require 'ibl.hooks'
    local highlight = {
      'RainbowRed',
      'RainbowYellow',
      'RainbowBlue',
      'RainbowOrange',
      'RainbowGreen',
      'RainbowViolet',
      'RainbowCyan',
    }

    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#E06C75' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#E5C07B' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#61AFEF' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#D19A66' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#98C379' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#C678DD' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#56B6C2' })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }

    ibl.setup(opts)
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    --[[
    -- Hide first level indent, using `foldsep` to show it
    hooks.register(hooks.type.VIRTUAL_TEXT, function(_, _, _, virt_text)
      if virt_text[1] and virt_text[1][1] == opts.indent.char then
        virt_text[1] = { ' ', { '@ibl.whitespace.char.1' } }
      end
      return virt_text
    end)
    -- ]]
  end,
}

return M
