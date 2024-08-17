local M = {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = function()
    -- Open parent directory in current window
    vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', { desc = 'oil' })

    -- Open parent directory in floating window
    vim.keymap.set('n', '<leader>O', require('oil').toggle_float, { desc = 'oil (float)' })

    require('oil').setup {
      columns = { 'icon' },
      buf_options = {
        buflisted = false,
        bufhidden = 'hide',
      },
      win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorcolumn = true,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
      },
      delete_to_trash = true, -- :h oil-trash
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = true,
      experimental_watch_for_changes = false,
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-s>'] = 'actions.select_split',
      },
      view_options = {
        show_hidden = true,
      },
      lsp_file_methods = {
        timeout_ms = 1000,
        autosave_changes = 'unmodified',
      },
    }
  end,
}

return M
