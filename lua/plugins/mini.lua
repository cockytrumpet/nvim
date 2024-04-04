local M = { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  event = 'VimEnter',
  config = function()
    -- Split/Joint lines
    require('mini.splitjoin').setup {
      -- Use default keymaps
      use_default_keymaps = true,
    }

    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]parenthen
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    -- require('mini.statusline').setup()
    -- don't use animate when scrolling with the mouse
    local mouse_scrolled = false
    for _, scroll in ipairs { 'Up', 'Down' } do
      local key = '<ScrollWheel' .. scroll .. '>'
      vim.keymap.set({ '', 'i' }, key, function()
        mouse_scrolled = true
        return key
      end, { expr = true })
    end

    local animate = require 'mini.animate'

    require('mini.animate').setup {
      -- resize = {
      -- timing = animate.gen_timing.linear { duration = 100, unit = 'total' },
      -- },
      scroll = {
        -- timing = animate.gen_timing.linear { duration = 150, unit = 'total' },
        subscroll = animate.gen_subscroll.equal {
          predicate = function(total_scroll)
            if mouse_scrolled then
              mouse_scrolled = false
              return false
            end
            return total_scroll > 1
          end,
        },
      },
    }

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}

return M
