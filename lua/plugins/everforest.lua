local M = {
  'neanias/everforest-nvim',
  version = false,
  event = 'VeryLazy',
  -- lazy = false,
  -- priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    local everforest = require 'everforest'
    everforest.setup {
      background = 'hard',
      transparent_background_level = 0,
      italics = true,
      disable_italic_comments = false,
      on_highlights = function(hl, _)
        -- hl['@symbol'] = { link = '@field' }
        -- hl['FloatBorder'] { guifg=#859289, guibg=#3d484d }
        hl['FloatBorder'] = { link = 'Gray' }
      end,
    }
    -- everforest.load()
  end,
}

return M
