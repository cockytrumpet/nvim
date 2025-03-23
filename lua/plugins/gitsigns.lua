local M = { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      -- delete = { text = '󰍵' },
      delete = { text = '│' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '│' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { desc = 'next hunk', expr = true })

      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { desc = 'previous hunk', expr = true })

      -- Actions
      map('n', '<leader>gs', gs.stage_hunk, { desc = 'stage hunk' })
      map('n', '<leader>gr', gs.reset_hunk, { desc = 'reset hunk' })
      map('v', '<leader>gs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Stage hunk' })
      map('v', '<leader>gr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Reset hunk' })
      map('n', '<leader>gS', gs.stage_buffer, { desc = 'stage buffer' })
      map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
      map('n', '<leader>gR', gs.reset_buffer, { desc = 'reset buffer' })
      map('n', '<leader>gp', gs.preview_hunk, { desc = 'preview hunk' })
      map('n', '<leader>gb', function()
        gs.blame_line { full = true }
      end, { desc = 'blame line' })
      map('n', '<leader>gt', gs.toggle_current_line_blame, { desc = 'blame line toggle' })
      map('n', '<leader>gd', gs.diffthis, { desc = 'diff' })
      map('n', '<leader>gD', function()
        gs.diffthis '~'
      end, { desc = 'diff all' })
      map('n', '<leader>gT', gs.toggle_deleted, { desc = 'toggle deleted ' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'text object' })
    end,
  },
  config = function(_, opts)
    require('gitsigns').setup(opts)
  end,
}

return M
