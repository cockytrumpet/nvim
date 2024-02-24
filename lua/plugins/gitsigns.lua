local M = { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  event = 'BufWinEnter',
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '󰍵' },
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
      end, { expr = true })

      map('n', '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true })

      -- Actions
      map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
      map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
      map('v', '<leader>hs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Stage hunk' })
      map('v', '<leader>hr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Reset hunk' })
      map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
      map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
      map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
      map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
      map('n', '<leader>hb', function()
        gs.blame_line { full = true }
      end, { desc = 'Blame line' })
      map('n', '<leader>ht', gs.toggle_current_line_blame, { desc = 'Blame line toggle' })
      map('n', '<leader>hd', gs.diffthis, { desc = 'Diff' })
      map('n', '<leader>hD', function()
        gs.diffthis '~'
      end, { desc = 'Diff all' })
      map('n', '<leader>hT', gs.toggle_deleted, { desc = 'Toggle deleted ' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Text object' })
    end,
  },
  config = function(_, opts)
    require('gitsigns').setup(opts)
  end,
}

return M
