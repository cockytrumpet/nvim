local M = { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
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

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'file_browser')
    pcall(require('telescope').load_extension, 'luasnip')
    pcall(require('telescope').load_extension, 'gpt')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    --[[
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })
]]
    -- Shortcut for searching your neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files {
        cwd = vim.fn.stdpath 'config',
      }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}

return M
