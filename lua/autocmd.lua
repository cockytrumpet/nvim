-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- turn off cursorline when entering buffer
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    vim.opt.cursorline = true
  end,
})

-- turn on cursorline when leaving buffers
vim.api.nvim_create_autocmd('BufLeave', {
  pattern = '*',
  callback = function()
    vim.opt.cursorline = false
    vim.lsp.buf.clear_references()
  end,
})

-- turn off ufo in these
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'neotest-summary',
    'Neogit*',
    'terminal',
    'diff',
    'undotree',
    'Outline',
    'man',
    'help',
    'neo-tree',
    'starter',
    'TelescopePrompt',
    'Trouble',
    'NvimTree',
    'NvimTree_1',
    'dapui_watches',
    'dap-repl',
    'dapui_console',
    'dapui_stacks',
    'dapui_breakpoints',
    'dapui_scopes',
    'themes',
    'terminal',
    'copilot-chat',
  },
  callback = function()
    require('ufo').detach()
    vim.opt_local.foldenable = false
  end,
})

-- turn scroll off in these
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'noice', 'neotest-output', 'neotest-summary', 'neotest-output-panel', 'help' },
  callback = function()
    vim.o.scrolloff = 0
    vim.o.number = false
    vim.o.relativenumber = false
  end,
})

-- turn off in terminal
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNew' }, {
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.o.scrolloff = 0
      vim.o.number = false
      vim.o.relativenumber = false
      vim.cmd 'startinsert | 1'
    end
  end,
})

-- wrap in these filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'markdown', 'text', 'log', 'help', 'noice' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = 'Enable Wrap in these filetypes',
})

-- Auto resize panes when resizing nvim window
vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'tabdo wincmd =',
})

--[[ -- Nvimtree open file on creation
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function()
    require('nvim-tree.api').events.subscribe('FileCreated', function(file)
      vim.cmd('edit ' .. file.fname)
    end)
  end,
})
]]
-- Don't auto comment new line
vim.api.nvim_create_autocmd('BufEnter', {
  command = [[set formatoptions-=cro]],
})

--- Remove all trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[:%s/\s\+$//e]],
  group = vim.api.nvim_create_augroup('TrimWhiteSpaceGrp', { clear = true }),
})

-- Restore cursor
vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  pattern = { '*' },
  callback = function()
    vim.cmd 'silent! normal! g`"zv'
  end,
})

-- Windows to close with "q"
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'startuptime',
    'qf',
    'lspinfo',
    'man',
    'checkhealth',
    'tsplayground',
    'HIERARCHY-TREE-GO',
    'dap-float',
    'null-ls-info',
    'empty',
    -- 'neotest-output',
    'neotest-summary',
    'neotest-output-panel',
    'fugitive',
    'Outline',
    'notify',

    -- "Neogit*",
  },
  command = [[
            nnoremap <buffer><silent> q :close<CR>
            set nobuflisted
        ]],
})

-- start git messages in insert mode
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'gitrebase' },
  command = 'startinsert | 1',
})
