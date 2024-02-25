-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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
    'diff',
    'undotree',
  },
  callback = function()
    require('ufo').detach()
    vim.opt_local.foldenable = false
  end,
})

-- Disable status column in the following files
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNew' }, {
  callback = function()
    local ft_ignore = {
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
      'diff',
      'undotree',
    }

    if vim.tbl_contains(ft_ignore, vim.bo.buftype) then
      vim.cmd 'setlocal statuscolumn='
      vim.o.scrolloff = 0
      vim.o.number = false
      vim.o.relativenumber = false
    end

    if vim.tbl_contains(ft_ignore, vim.bo.filetype) then
      vim.cmd 'setlocal statuscolumn='
      vim.o.scrolloff = 0
      vim.o.number = false
      vim.o.relativenumber = false
    end

    if vim.bo.buftype == 'terminal' then
      vim.cmd 'startinsert | 1'
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit', 'markdown', 'text', 'log', 'help' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  group = general,
  desc = 'Enable Wrap in these filetypes',
})

-- Auto resize panes when resizing nvim window
vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  command = 'tabdo wincmd =',
})

-- Nvimtree open file on creation
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function()
    require('nvim-tree.api').events.subscribe('FileCreated', function(file)
      vim.cmd('edit ' .. file.fname)
    end)
  end,
})

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
    'neotest-output',
    'neotest-summary',
    'neotest-output-panel',
    'fugitive',
    'Outline',

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
