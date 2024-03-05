local cmp_kinds = {
  Text = '',
  Method = '󰆧',
  Function = '󰊕',
  Constructor = '',
  Field = '󰇽',
  Variable = '󰂡',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '󰅲',
  Codeium = '',
}

local M = { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'zbirenbaum/copilot-cmp',
    'jcdickinson/codeium.nvim',
    'onsails/lspkind.nvim',

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',

    -- If you want to add a bunch of pre-configured snippets,
    --    you can use this plugin to help you. It even has snippets
    --    for various frameworks/libraries/etc. but you will have to
    --    set up the ones that are useful for you.
    'rafamadriz/friendly-snippets',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    -- luasnip.config.setup {}

    cmp.setup {
      window = {
        completion = {
          scrolloff = 0,
          col_offset = 0,
          scrollbar = false,
          bordered = true,
          border = 'rounded',
          winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
        },
        documentation = {
          scrolloff = 0,
          col_offset = 0,
          scrollbar = false,
          bordered = true,
          border = 'rounded',
          winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
        },
      },
      completion = {
        completeopt = 'menu,menuone,noinsert,noselect',
        autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
        keyword_length = 1,
      },
      experimental = {
        --[[
        ghost_text = {
          hl_group = 'Comment',
        },
]]
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<C-y>'] = cmp.mapping.confirm { select = true },

        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        -- ['<C-Space>'] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
        ['<C-k>'] = cmp.mapping(function()
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'copilot' },
        { name = 'codeium', max_item_count = 2 },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'crates' },
      },
      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        expandable_indicator = true,
        format = function(entry, vim_item)
          local lspkind_ok, lspkind = pcall(require, 'lspkind')
          if not lspkind_ok then
            vim_item.kind = cmp_kinds[vim_item.kind] or ''
          else
            local custom_icon = {
              codeium = ' AI',
            }
            if entry.source.name == 'codeium' then
              vim_item.kind = custom_icon.codeium
            end

            return lspkind.cmp_format {
              menu = {
                buffer = '[Buffer]',
                nvim_lsp = '[LSP]',
                luasnip = '[LuaSnip]',
                nvim_lua = '[Lua]',
                copilot = '[Copilot]',
                codeium = '[Codeium]',
                ctags = '[Ctags]',
                treesitter = '[Treesitter]',
                path = '[Path]',
              },
            }(entry, vim_item)
          end
          return vim_item
        end,
      },
    }
  end,
}

return M
