local M = {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon').setup {}

      vim.keymap.set('n', '<leader>ht', function()
        harpoon:list():add()
      end, { desc = 'tag file' })
      vim.keymap.set('n', '<leader>he', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'edit list' })
      vim.keymap.set('n', '<leader>hf', function()
        harpoon:list():select(1)
      end, { desc = '1st' })
      vim.keymap.set('n', '<leader>hd', function()
        harpoon:list():select(2)
      end, { desc = '2nd' })
      vim.keymap.set('n', '<leader>hs', function()
        harpoon:list():select(3)
      end, { desc = '3rd' })
      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():select(4)
      end, { desc = '4th' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>hg', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<leader>hh', function()
        harpoon:list():next()
      end)
    end,
  },
}

return M
