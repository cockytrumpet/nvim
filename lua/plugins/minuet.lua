local M = {
  'milanglacier/minuet-ai.nvim',
  event = 'VeryLazy',
  config = function()
    require('minuet').setup {
      provider = 'openai_fim_compatible',
      provider_options = {
        openai_fim_compatible = {
          name = 'starcoder2-7b',
          model = 'starcoder2-7b-Q4_K_S',
          end_point = 'http://127.0.0.1:1234/v1/completions',
          api_key = 'OPENAI_API_KEY',
          stream = true,
          optional = {
            -- max_tokens = 1024,
            top_p = 0.9,
            stop = { '\n\n' },
          },
        },
      },
      sources = {
        -- Enable minuet for autocomplete
        default = { 'lsp', 'path', 'buffer', 'snippets', 'minuet' },
        -- For manual completion only, remove 'minuet' from default
        providers = {
          minuet = {
            name = 'minuet',
            module = 'minuet.blink',
            score_offset = 8, -- Gives minuet higher priority among suggestions
          },
        },
      },
      -- Recommended to avoid unnecessary request
      completion = { trigger = { prefetch_on_insert = false } },
    }
  end,
}

return M
