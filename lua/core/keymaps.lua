vim.keymap.set('n', '<Esc>', function()
  vim.cmd 'noh'
  vim.cmd 'Noice dismiss'
end)

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
-- vim.keymap.set({ 'n', 'v', 'x' }, 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = 'Move down' })
-- vim.keymap.set({ 'n', 'v', 'x' }, 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = 'Move up' })

vim.keymap.set({ 'n', 'v' }, '<C-c>', '<cmd> %y+ <CR>', { desc = 'Copy whole file' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>tv', '<CMD>vsplit term://zsh<CR>', { desc = 'Open terminal (vertical)' })
vim.keymap.set('n', '<leader>th', '<CMD>split term://zsh<CR>', { desc = 'Open terminal (horizontal)' })

vim.keymap.set('n', '<leader>b', '<CMD>enew<CR>', { desc = 'New buffer' })

vim.keymap.set('n', '<leader>/', function()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle comment' })

vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Toggle comment' })

vim.keymap.set('n', '<leader>zZ', function()
  require('zen-mode').setup {
    window = {
      width = 90,
      options = {},
    },
  }
  require('zen-mode').toggle()
  vim.wo.wrap = true
  vim.wo.number = true
  vim.wo.rnu = true
end)

vim.keymap.set('n', '<leader>zz', function()
  require('zen-mode').setup {
    window = {
      backdrop = 0.93,
      width = 100,
      height = 1,
    },
    plugins = {
      options = {
        enabled = true,
        showcmd = false,
        laststatus = 0,
      },
      -- twilight = { enabled = false },
      gitsigns = { enabled = true },
      wezterm = {
        enabled = true,
        -- can be either an absolute font size or the number of incremental steps
        font = '+2', -- (10% increase per step)
      },
      tmux = { enabled = true },
    },
  }
  require('zen-mode').toggle()
end)

vim.keymap.set('n', '<leader>rf', function()
  _G.run_code()
end, { desc = 'run file' })

vim.keymap.set('n', '<leader>m', '<CMD>TSJToggle<CR>', { desc = 'Split/Join' })

vim.keymap.set('n', '<leader>qf', '<cmd>TroubleToggle quickfix<cr>', { desc = 'Toggle quickfix' })
vim.keymap.set('n', '<leader>tw', '<CMD>TroubleToggle<CR>', { desc = '󰔫 Toggle warnings' })
vim.keymap.set('n', '<leader>td', '<CMD>TodoTrouble keywords=TODO,FIX,FIXME,BUG,TEST,NOTE<CR>', { desc = ' Todo/Fix/Fixme' })
vim.keymap.set('n', '<leader>st', '<CMD>TodoTelescope<CR>', { desc = ' [S]earch [T]ODO' })
vim.keymap.set('n', '<leader>sc', '<CMD>Telescope git_status<CR>', { desc = ' [S]earch [C]hanges (git)' })
vim.keymap.set('n', '<leader>sm', function()
  require('telescope').extensions.notify.notify()
end, { desc = ' [S]earch [M]essage history' })

vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle nvimtree' })

vim.keymap.set('n', '<leader>fm', function()
  require('conform').format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 4000,
  }
end, { desc = 'Format file or range (in visual mode)' })

vim.keymap.set('n', '<leader>h', function()
  vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Inlay Hints' })

vim.keymap.set('n', 'gX', function()
  local word = vim.fn.expand '<cfile>'
  local url = 'https://github.com/' .. word
  vim.ui.open(url)
end, { desc = '󰙍 Open github repo' })

vim.keymap.set('i', '<C-Up>', '<CMD>m .-2<CR>==', { desc = '󰜸 Move line up' })
vim.keymap.set('i', '<C-Down>', '<CMD>m .+1<CR>==', { desc = '󰜯 Move line down' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<CMD>vertical resize -1<CR>', { desc = 'Vertical +' })
vim.keymap.set('n', '<right>', '<CMD>vertical resize +1<CR>', { desc = 'Vertical -' })
vim.keymap.set('n', '<up>', '<CMD>resize -1<CR>', { desc = 'Horizontal +' })
vim.keymap.set('n', '<down>', '<CMD>resize +1<CR>', { desc = 'Horizontal -' })

vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>tp', '<CMD>tabp<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tn', '<CMD>$tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', '<CMD>tabc<CR>', { desc = 'Close tab' })

vim.keymap.set('n', 'gw', '<CMD>silent grep! <cword> | cw<CR>', { desc = 'Grep word' })

vim.keymap.set('n', 'zR', function()
  require('ufo').openAllFolds()
end, { desc = 'Open all folds' })

vim.keymap.set('n', 'zM', function()
  require('ufo').closeAllFolds()
end, { desc = 'Close all folds' })

vim.keymap.set('n', 'zr', function()
  require('ufo').openFoldsExceptKinds()
end, { desc = 'Open all folds except kinds' })

vim.keymap.set('n', 'zm', function()
  require('ufo').closeFoldsWith()
end, { desc = 'Close all folds with' })

vim.keymap.set('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = 'Peek Definition' })
