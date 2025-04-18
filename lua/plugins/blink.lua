local M = {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = {
    'rafamadriz/friendly-snippets',
  },

  -- use a release tag to download pre-built binaries
  -- version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = 'default',
      ['<A-y>'] = {
        function(cmp)
          cmp.show { providers = { 'minuet' } }
        end,
      }, -- ['<A-y>'] = require('minuet').make_blink_map(),
    },
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        minuet = {
          name = 'minuet',
          module = 'minuet.blink',
          score_offset = 8, -- Gives minuet higher priority among suggestions
        },
      },
    },
    signature = { enabled = true },
    completion = {
      menu = {
        border = 'rounded',
        draw = {
          columns = { { 'kind_icon', 'label', 'label_description', gap = 1 }, { 'kind' } },
        },
      },
      documentation = { window = { border = 'rounded' } },

      trigger = { prefetch_on_insert = false },
    },
  },
  opts_extend = { 'sources.default' },
}

return M
