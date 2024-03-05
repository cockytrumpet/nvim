local M = {
  'L3MON4D3/LuaSnip',
  dependencies = { 'rafamadriz/friendly-snippets' },
  event = 'InsertEnter',
  opts = function()
    local types = require 'luasnip.util.types'
    local ls = require 'luasnip'

    require('luasnip').config.set_config {
      enable_autosnippets = true,
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      snip_env = {
        s = function(...)
          local snip = ls.s(...)
          -- we can't just access the global `ls_file_snippets`, since it will be
          -- resolved in the environment of the scope in which it was defined.
          table.insert(getfenv(2).ls_file_snippets, snip)
        end,
        parse = function(...)
          local snip = ls.parser.parse_snippet(...)
          table.insert(getfenv(2).ls_file_snippets, snip)
        end,
      },
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '<-', 'Error' } },
          },
        },
      },
    }

    -- vscode format
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load { paths = vim.g.vscode_snippets_path or '' }

    -- snipmate format
    require('luasnip.loaders.from_snipmate').load()
    require('luasnip.loaders.from_snipmate').lazy_load { paths = vim.g.snipmate_snippets_path or '' }

    -- lua format
    -- require('luasnip.loaders.from_lua').load()
    require('luasnip.loaders.from_lua').load()
    require('luasnip.loaders.from_lua').lazy_load { paths = vim.g.lua_snippets_path or '' }

    vim.api.nvim_create_autocmd('InsertLeave', {
      callback = function()
        if require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()] and not require('luasnip').session.jump_active then
          require('luasnip').unlink_current()
        end
      end,
    })

    vim.keymap.set('n', '<leader>rs', function()
      local paths = vim.split(vim.fn.glob '~/.config/nvim/lua/snippets/*lua', '\n')
      for _, file in pairs(paths) do
        vim.notify('Reloading ' .. file, 'info', { title = 'LuaSnip' })
        vim.cmd('source ' .. file)
      end
    end, { desc = 'Reload Snippets' })
  end,
  build = function()
    -- Build Step is needed for regex support in snippets
    if vim.fn.executable 'make' == 0 then
      return
    end
    return 'make install_jsregexp'
  end,
}

return M
