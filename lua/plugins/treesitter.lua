local M = { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufRead',
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'bash', 'html', 'c', 'markdown', 'lua', 'vim', 'vimdoc', 'python', 'go', 'rust' },
      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    }
  end,
}

return M
