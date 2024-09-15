-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

local signs = {
  Error = '',
  Warn = '',
  Hint = '',
  Info = '',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config {
  -- virtual_text = false,

  virtual_text = {
    source = 'if_many',
    prefix = '●',
  },

  float = {
    source = 'if_many',
    border = 'rounded',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  on_ready = function()
    -- vim.cmd 'highlight DiagnosticVirtualText guibg=NONE'
  end,
}

local M = { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'folke/lazydev.nvim',
    {
      'j-hui/fidget.nvim',
      event = 'VeryLazy',
    },
  },
  config = function()
    require('lspconfig.ui.windows').default_options.border = 'single'
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = '' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  To jump back, press <C-T>.
        map('gd', require('telescope.builtin').lsp_definitions, 'goto definition')

        -- Find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, 'goto references')

        -- Jump to the implementation of the word under your cursor.
        map('gI', require('telescope.builtin').lsp_implementations, 'goto implementation')

        -- Jump to the type of the word under your cursor.
        -- map('<leader>gt', require('telescope.builtin').lsp_type_definitions, '[g]oto [t]ype definition')

        -- Fuzzy find all the symbols in your current document.
        map('<leader>fs', require('telescope.builtin').lsp_document_symbols, 'document symbols')

        -- Fuzzy find all the symbols in your current workspace
        map('<leader>fS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'workspace symbols')

        -- Rename the variable under your cursor
        map('<leader>rn', vim.lsp.buf.rename, 'rename')

        -- Execute a code action, usually your cursor needs to be on top of an error
        map('<leader>ca', vim.lsp.buf.code_action, 'code action')
        --[[
        map('<leader>ca', function()
          vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
        end, 'code action')
]]
        -- Show the signature of the function you're currently completing.
        map('<leader>K', vim.lsp.buf.signature_help, 'signature documentation')

        map('gD', vim.lsp.buf.declaration, 'goto declaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    -- capabilities = vim.tbl_deep_extend('force', capabilities, require('rustaceanvim.config.server').create_client_capabilities())

    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      -- If you use something like typescript, where the tooling is as bad as the language,
      -- then you might need to install and configure something like this:
      --    https://github.com/pmizio/typescript-tools.nvim
      --
      -- If you only have simple needs for typescript, then you can probably just use tsserver
      -- ts_ls = {},
      clangd = {
        cmd = {
          'clangd',
          '--offset-encoding=utf-16',
        },
      },

      basedpyright = {
        cmd = { 'basedpyright-langserver', '--stdio' },
        filetypes = { 'python' },
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = 'openFilesOnly',
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
              typeCheckingMode = 'basic',
              reportUnusedFunction = false,
            },
          },
          extraPaths = {
            '/Users/adam/.pyenv/versions',
          },
        },
        single_file_support = true,
      },
      --[[
      pyright = {
        cmd = { 'pyright-langserver', '--stdio', '--pythonPath ', '/Users/adam/.pyenv/shims/python3' },
        filetypes = { 'python' },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'off',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              -- diagnosticMode = "openFilesOnly",
            },
            pyright = {
              autoImportCompletion = true,
            },
            -- venvPath = "/Users/adam/.pyenv/versions",
            -- venv = "ml-3.10.13",
          },
        },
        single_file = true,
      },
      ruff_lsp = {
        -- organize imports disabled, since we are already using `isort` for that
        -- alternative, this can be enabled to make `organize imports`
        -- available as code action
        settings = {
          organizeImports = true,
        },
        -- disable ruff as hover provider to avoid conflicts with pyright
        on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end,
      },
]]
      gopls = {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_dir = require('lspconfig.util').root_pattern('go.work', 'go.mod', '.git'),
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            completeUnimported = true,
            usePlaceholders = true,
          },
        },
      },

      lua_ls = {
        -- cmd = {...},
        -- filetypes { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              -- Tells lua_ls where to find all the Lua files that you have loaded
              -- for your neovim configuration.
              library = {
                'lua',
                '$VIMRUNTIME/lua',
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
              maxPreload = 100000,
              preloadFileSize = 10000,

              -- If lua_ls is really slow on your computer, you can try this instead:
              -- library = { vim.env.VIMRUNTIME },
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
            diagnostics = {
              globals = { 'vim' },
              disable = {
                'missing-fields',
              },
            },
            hint = {
              enable = true,
              setType = true,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },

      omnisharp = {
        cmd = { 'omnisharp' },
        enable_roslyn_analyzers = true,
        -- analyze_open_documents_only = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
      },
    }

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- markdown
      'marksman',

      -- lua stuff
      'stylua',

      -- web dev stuff
      'css-lsp',
      'html-lsp',
      'typescript-language-server',
      'deno',
      'prettier',
      'eslint',

      -- c/cpp stuff
      'clang-format',
      'codelldb',

      -- Python
      'black',
      'debugpy',
      'isort',
      'pylint',

      -- Json
      'jsonlint',
      'json-lsp',

      -- Ocaml
      'ocaml-lsp',
      'ocamlformat',

      -- Rust
      -- 'rust-analyzer',

      'dockerfile-language-server',
      'yaml-language-server',
      'gopls',
    })

    -- Ensure the servers and tools above are installed
    require('mason').setup { ui = { border = 'rounded' } }
    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
      auto_update = true,
      run_on_start = true,
    }
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}

return M
