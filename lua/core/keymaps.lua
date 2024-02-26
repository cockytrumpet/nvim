-- [[ General ]]
vim.keymap.set('n', '<Esc>', function()
  vim.cmd 'noh'
  vim.cmd 'Noice dismiss'
end)

vim.keymap.set('n', '<leader>x', '<CMD>bd<CR>', { desc = 'Close buffer' })
vim.keymap.set({ 'n', 'v' }, '<C-c>', '<cmd> %y+ <CR>', { desc = 'Copy whole file' })
vim.keymap.set('n', '<leader>tp', '<CMD>tabp<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tn', '<CMD>$tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', '<CMD>tabc<CR>', { desc = 'Close tab' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- vim.keymap.set('n', '<leader>tv', '<CMD>vsplit term://zsh<CR>', { desc = 'Open terminal (vertical)' })
-- vim.keymap.set('n', '<leader>th', '<CMD>split term://zsh<CR>', { desc = 'Open terminal (horizontal)' })

vim.keymap.set('i', '<C-Up>', '<CMD>m .-2<CR>==', { desc = '󰜸 Move line up' })
vim.keymap.set('i', '<C-Down>', '<CMD>m .+1<CR>==', { desc = '󰜯 Move line down' })
vim.keymap.set('n', '<left>', '<CMD>vertical resize -1<CR>', { desc = 'Vertical +' })
vim.keymap.set('n', '<right>', '<CMD>vertical resize +1<CR>', { desc = 'Vertical -' })
vim.keymap.set('n', '<up>', '<CMD>resize -1<CR>', { desc = 'Horizontal +' })
vim.keymap.set('n', '<down>', '<CMD>resize +1<CR>', { desc = 'Horizontal -' })

vim.keymap.set('n', 'gw', '<CMD>silent grep! <cword> | cw<CR>', { desc = 'Grep word' })

vim.keymap.set('n', 'gX', function()
  local word = vim.fn.expand '<cfile>'
  local url = 'https://github.com/' .. word
  vim.ui.open(url)
end, { desc = '󰙍 Open github repo' })

-- [[ Diagnostic/LSP ]]
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })
vim.keymap.set('n', '<leader>rf', function()
  _G.run_code()
end, { desc = 'run file' })
vim.keymap.set('n', '<leader>f', function()
  require('conform').format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 4000,
  }
end, { desc = 'Format file' })
vim.keymap.set('n', '<leader>i', function()
  vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Inlay Hints' })

-- [[ Plugin specific ]]
vim.keymap.set('n', '<leader>gg', '<CMD>Neogit<CR>', { desc = 'Neogit' })
