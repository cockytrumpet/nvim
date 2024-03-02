-- Highlight group from rainbow-delimiters
local highlight = {
  'RainbowDelimiterRed',
  'RainbowDelimiterYellow',
  'RainbowDelimiterBlue',
  'RainbowDelimiterOrange',
  'RainbowDelimiterGreen',
  'RainbowDelimiterViolet',
  'RainbowDelimiterCyan',
}

return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  opts = {
    indent = {
      char = '▏', -- Thiner, not suitable when enable scope
      tab_char = '▏',
      -- highlight = highlight,
    },
    scope = {
      -- Rely on treesitter, bad performance
      enabled = true,
      highlight = highlight,
      include = {
        node_type = {
          lua = { 'return_statement', 'table_constructor' },
          python = { 'function_definition', 'class_definition', 'for_statement', 'while_statement' },
        },
      },
    },
  },
  config = function(_, opts)
    local ibl = require 'ibl'
    local hooks = require 'ibl.hooks'

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
