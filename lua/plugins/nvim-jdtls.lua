local M = {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'mfussenegger/nvim-dap',
    --[[ {
      'ray-x/lsp_signature.nvim',
      event = 'LspAttach',
      opts = {
        bind = true,
        handler_opts = {
          border = 'rounded',
        },
        hint_prefix = {
          above = '↙ ', -- when the hint is on the line above the current line
          current = '← ', -- when the hint is on the same line
          below = '↖ ', -- when the hint is on the line below the current line
        },
        -- fix_pos = false,
        hint_inline = function()
          return false
        end, -- should the hint be inline(nvim 0.10 only)?  default false
        -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
        -- return 'right_align' to display hint right aligned in the current line
        keymaps = {}, -- relate to move_cursor_key; the keymaps inside floating window with arguments of bufnr
        -- e.g. keymaps = function(bufnr) vim.keymap.set(...) end
        -- it can be function that set keymaps
        -- e.g. keymaps = { { 'j', '<C-o>j' }, } this map j to <C-o>j in floating window
        -- <M-d> and <M-u> are default keymaps to move cursor up and down
      },
      config = function(_, opts)
        require('lsp_signature').setup(opts)
      end,
    }, ]]
  },
}

return M
