local M = {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VimEnter',
  config = function()
    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'Buffer: cycle next' })
    vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'Buffer: cycle prev' })
    vim.keymap.set('n', '<leader>bp', ':BufferLinePick<CR>', { noremap = true, silent = true, desc = 'Buffer: pick' })
    vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { noremap = true, silent = true, desc = 'Buffer: pick close' })
    vim.keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true, desc = 'Buffer: 1' })
    vim.keymap.set('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true, desc = 'Buffer: 2' })
    vim.keymap.set('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true, desc = 'Buffer: 3' })
    vim.keymap.set('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true, desc = 'Buffer: 4' })
    vim.keymap.set('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true, desc = 'Buffer: 5' })
    vim.keymap.set('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true, desc = 'Buffer: 6' })
    vim.keymap.set('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true, desc = 'Buffer: 7' })
    vim.keymap.set('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true, desc = 'Buffer: 8' })
    vim.keymap.set('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true, desc = 'Buffer: 9' })
    vim.keymap.set('n', '<leader>bl', '<Cmd>BufferLineMovePrev<CR>', { noremap = true, silent = true, desc = 'Buffer: move left' })
    vim.keymap.set('n', '<leader>br', '<Cmd>BufferLineMoveNext<CR>', { noremap = true, silent = true, desc = 'Buffer: move right' })

    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.minimal,
        offsets = {
          {
            filetype = 'NvimTree',
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        -- diagnostics = 'nvim_lsp',
      },
    }
  end,
}

return M
