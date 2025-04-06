local M = {
  'milanglacier/minuet-ai.nvim',
  event = 'VeryLazy',
  config = function()
    require('vectorcode').setup {
      -- number of retrieved documents
      n_query = 1,
    }
    local has_vc, vectorcode_config = pcall(require, 'vectorcode.config')
    local vectorcode_cacher = nil
    if has_vc then
      vectorcode_cacher = vectorcode_config.get_cacher_backend()
    end

    require('minuet').setup {
      provider = 'openai_fim_compatible',
      provider_options = {
        openai_fim_compatible = {
          name = 'starcoder2-7b',
          model = 'starcoder2-7b',
          end_point = 'http://127.0.0.1:1234/v1/completions',
          api_key = 'OPENAI_API_KEY',
          stream = true,
          optional = {
            -- max_tokens = 1024,
            top_p = 0.9,
            stop = { '\n\n' },
          },
          template = {
            prompt = function(pref, suff)
              local prompt_message = ''
              local cache_result = vectorcode_cacher.query_from_cache(0)
              for _, file in ipairs(cache_result) do
                prompt_message = prompt_message .. '<file_sep>' .. file.path .. '\n' .. file.document
              end
              return prompt_message .. '<fim_prefix>' .. pref .. '<fim_suffix>' .. suff .. '<fim_middle>'
            end,
            suffix = false,
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
