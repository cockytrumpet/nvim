local utils = require 'utils'

-- [[ General ]]
vim.keymap.set('n', '<Esc>', function()
  vim.cmd 'noh'
  vim.cmd 'Noice dismiss'
end)
vim.keymap.set('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, replace_keycodes = false, desc = 'Visually select changed text' })
--[[
vim.keymap.set('n', '<leader>x', function()
  utils.close_current_buffer()
end, { desc = 'close buffer' })
]]
vim.keymap.set('n', '<leader>x', '<CMD>bd<CR>', { desc = 'close buffer' })

vim.keymap.set({ 'n', 'v' }, '<C-c>', '<cmd> %y+ <CR>', { desc = 'copy whole file' })
vim.keymap.set('n', '<leader>tp', '<CMD>tabp<CR>', { desc = 'previous tab' })
vim.keymap.set('n', '<leader>tn', '<CMD>$tabnew<CR>', { desc = 'new tab' })
vim.keymap.set('n', '<leader>tc', '<CMD>tabc<CR>', { desc = 'close tab' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'exit terminal mode' })

vim.keymap.set('n', 'gO', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = 'insert line(s) above' })
vim.keymap.set('n', 'go', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = 'insert line(s) below' })
vim.keymap.set('i', '<C-Up>', '<CMD>m .-2<CR>==', { desc = '󰜸 move line up' })
vim.keymap.set('i', '<C-Down>', '<CMD>m .+1<CR>==', { desc = '󰜯 move line down' })
vim.keymap.set('n', '<left>', '<CMD>vertical resize -1<CR>', { desc = 'vertical +' })
vim.keymap.set('n', '<right>', '<CMD>vertical resize +1<CR>', { desc = 'vertical -' })
vim.keymap.set('n', '<up>', '<CMD>resize -1<CR>', { desc = 'horizontal +' })
vim.keymap.set('n', '<down>', '<CMD>resize +1<CR>', { desc = 'horizontal -' })

vim.keymap.set('n', 'gw', '<CMD>silent grep! <cword> | cw<CR>', { desc = 'grep word' })

vim.keymap.set('n', 'gm', function()
  local cmd = ':vertical Man ' .. vim.fn.expand '<cword>'
  vim.cmd(cmd)
end, { desc = 'open man page' })

vim.keymap.set('n', 'gX', function()
  local word = vim.fn.expand '<cfile>'
  local url = 'https://github.com/' .. word
  vim.ui.open(url)
end, { desc = '󰙍 Open github repo' })

-- [[ Diagnostic/LSP ]]
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'show diagnostic error messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'open diagnostic quickfix list' })
--[[
vim.keymap.set('n', '<leader>rf', function()
  _G.run_code()
end, { desc = 'run file' })
]]
vim.keymap.set('n', '<leader>a', function()
  require('conform').format {
    lsp_fallback = true,
    async = false,
    timeout_ms = 2000,
  }
end, { desc = 'auto-format file' })
vim.keymap.set('n', '<leader>i', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Inlay Hints' })

-- [[ colorscheme ]]
vim.keymap.set('n', '<leader>fT', function() -- Show all custom colors in telescope
  vim.schedule(function()
    utils.telescope_custom_colors()
  end)
end, { desc = 'themes', silent = true })

-- [[ Plugin specific ]]
vim.keymap.set('n', '<leader>gg', '<CMD>Neogit<CR>', { desc = 'Neogit' })
vim.keymap.set('n', '<leader>S', function()
  require('mini.splitjoin').toggle()
end, { desc = 'split/join' })
