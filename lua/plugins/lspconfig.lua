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
  virtual_lines = false,
  virtual_text = {
    source = 'always',
    prefix = '■',
  },
  -- virtual_text = false,
  float = {
    source = 'always',
    border = 'rounded',
  },
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = true,
}

local M = { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'folke/neodev.nvim',
    { 'j-hui/fidget.nvim', event = 'VeryLazy', opts = {} },
  },
  config = function()
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

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

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
      -- tsserver = {},
      clangd = {
        cmd = {
          'clangd',
          '--offset-encoding=utf-16',
        },
      },

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
        -- single_file = true,
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

      gopls = {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        --[[ root_dir = lspconfig.util.root_pattern('go.work', 'go.mod', '.git'), ]]
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
    }

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- lua stuff
      'stylua',

      -- web dev stuff
      'css-lsp',
      'html-lsp',
      'typescript-language-server',
      'deno',
      'prettier',

      -- c/cpp stuff
      'clang-format',
      'codelldb',

      -- Python
      'black',
      'debugpy',
      'isort',

      -- Json
      'jsonlint',
      'json-lsp',

      -- Ocaml
      'ocaml-lsp',
      'ocamlformat',

      -- Rust
      'rust-analyzer',

      'dockerfile-language-server',
      'yaml-language-server',
    })

    -- Ensure the servers and tools above are installed
    require('neodev').setup()
    require('mason').setup()
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}

return M
