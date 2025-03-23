local escape_and_clear = function()
  return '<Esc><Esc>'
end

local M = {
  'max397574/better-escape.nvim',
  event = 'insertEnter',
  config = function()
    -- default settings
    require('better_escape').setup {
      timeout = vim.o.timeoutlen,
      default_mappings = true,
      mappings = {
        i = {
          j = {
            -- These can all also be functions
            k = escape_and_clear(),
            j = escape_and_clear(),
          },
        },
        c = {
          j = {
            k = escape_and_clear(),
            j = escape_and_clear(),
          },
        },
        t = {
          j = {
            k = escape_and_clear(),
            j = escape_and_clear(),
          },
        },
        v = {
          j = {
            k = escape_and_clear(),
          },
        },
        s = {
          j = {
            k = escape_and_clear(),
          },
        },
      },
    }
  end,
}

return M
