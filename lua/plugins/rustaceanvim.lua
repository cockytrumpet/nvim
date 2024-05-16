local M = {
  'mrcjkb/rustaceanvim',
  version = '^4', -- Recommended
  -- ft = { 'rust' },
  lazy = false,
  dependencies = {
    {
      'saecki/crates.nvim',
      ft = { 'rust', 'toml' },
      config = function(_, opts)
        local crates = require 'crates'
        crates.setup(opts)
        crates.show()
      end,
    },
  },
}

return M
