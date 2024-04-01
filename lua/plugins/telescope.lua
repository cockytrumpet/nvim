local M = { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    {
      'isak102/telescope-git-file-history.nvim',
      dependencies = { 'tpope/vim-fugitive' },
    },
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
    'benfowler/telescope-luasnip.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      -- `cond` is a condition used to determine whether this plugin should be installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    {
      'nvim-telescope/telescope-file-browser.nvim',
      dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    },
    {
      'HPRIOR/telescope-gpt',
      dependencies = { 'nvim-telescope/telescope.nvim', 'jackMort/ChatGPT.nvim' },
    },
  },
  config = function()
    -- Insert mode: <c-/>
    -- Normal mode: ?

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        ['gpt'] = {
          title = 'Gpt Actions',
          commands = {
            'add_tests',
            'chat',
            'docstring',
            'explain_code',
            'fix_bugs',
            'grammar_correction',
            'interactive',
            'optimize_code',
            'summarize',
            'translate',
          },
          theme = require('telescope.themes').get_dropdown {},
        },
      },
    }
    --[[
    local trouble = require 'trouble.providers.telescope'

    local telescope = require 'telescope'

    telescope.setup {
      defaults = {
        mappings = {
          i = { ['<c-t>'] = trouble.open_with_trouble },
          n = { ['<c-t>'] = trouble.open_with_trouble },
        },
      },
    }
]]
    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'file_browser')
    pcall(require('telescope').load_extension, 'luasnip')
    pcall(require('telescope').load_extension, 'gpt')
    pcall(require('telescope').load_extension, 'git_file_history')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>gh', '<CMD>Telescope git_file_history<CR>', { desc = 'file history' })
    vim.keymap.set('n', '<leader>fb', '<CMD>Telescope file_browser<CR>', { desc = 'file browser' })
    vim.keymap.set('n', '<leader>fc', '<CMD>Telescope gpt<CR>', { desc = 'ChatGPT' })
    vim.keymap.set('n', '<leader>fg', '<CMD>Telescope git_status<CR>', { desc = 'git' })
    vim.keymap.set('n', '<leader>fm', function()
      require('telescope').extensions.notify.notify()
    end, { desc = 'message history' })
    -- vim.keymap.set('n', '<leader>ft', '<CMD>TodoTelescope<CR>', { desc = 'Todo' })

    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'diagnostics' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'files' })
    vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = 'live grep' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'keymaps' })
    vim.keymap.set('n', '<leader>fp', builtin.builtin, { desc = 'picker' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'grep current word' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'recent files' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'open buffers' })
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files {
        cwd = vim.fn.stdpath 'config',
      }
    end, { desc = 'neovim files' })
    --[[
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[/] in Open Files' })
]]
  end,
}

return M
